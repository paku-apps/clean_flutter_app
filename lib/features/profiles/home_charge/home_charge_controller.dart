import 'package:clean_app/data/model/assign_child.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/assign_child_repository.dart';
import 'package:clean_app/data/repository/qr_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeChargeController extends GetxController with SingleGetTickerProviderMixin {

  final AuthenticationController _authenticationController = Get.find();
  var usuarioLogged = User().obs;
  var listAssignChildrenToday = List<AssignChildModel>.empty().obs;
  var listAssignChildrenProgram = List<AssignChildModel>.empty().obs;
  var listOriginalPriority = List<int>.empty().obs;

  var loadingToday = false.obs;
  var loadingFuture = false.obs;

  var tabIndex = 0.obs;
  
  late TabController tabBarcontroller;

  final List<Tab> tabCharger = <Tab>[
    const Tab(text: 'Hoy'),
    const Tab(text: 'Programados'),
  ];

  @override
  void onInit(){
    super.onInit();
    getUserLogged();
    tabBarcontroller = TabController(length: tabCharger.length, vsync: this, initialIndex: 0);
    getauthorizationsForToday();
  }

  void reloadInitData(){
    getauthorizationsForToday();
  }

  Future<User?> getUserLogged() async {
    UserRepository repo = UserRepositoryImpl();
    var currentUser = await repo.getCurrentUser();
    if(currentUser!=null){
      usuarioLogged.value = currentUser;
    }
    update();
    return currentUser;
  }

  Future<List<AssignChildModel>> getauthorizationsForToday() async {
    loadingToday.value = true;
    UserRepository repoUsuario = UserRepositoryImpl();
    var currentUser = await repoUsuario.getCurrentUser();
    AssignChildRepository repo = AssignChildRepositoryImpl();
    List<AssignChildModel>? list = await repo.getListAssignChildToday(currentUser!.id);
    
    List<AssignChildModel> listPriorized = list.where((child) => child.priorizado).toList();
    List<AssignChildModel> listNotPriorized = list.where((child) => !child.priorizado).toList();

    listAssignChildrenToday.value = listPriorized + listNotPriorized;
    loadingToday.value = false;
    update();
    return list;
  }

  Future<List<AssignChildModel>> getauthorizationsForFuture() async {
    loadingFuture.value = true;
    UserRepository repoUsuario = UserRepositoryImpl();
    var currentUser = await repoUsuario.getCurrentUser();
    AssignChildRepository repo = AssignChildRepositoryImpl();
    List<AssignChildModel>? list = await repo.getListAssignChildFuture(currentUser!.id);
    listAssignChildrenProgram.value = list;
    loadingFuture.value = false;
    update();
    return list;
  }

  Future<void> savePositionForChildren() async {
    loadingToday.value = true;
    var listCheckPriority = [];
    for (var e in listAssignChildrenToday.value) {
      {
      if(e.priorizado){
        listCheckPriority.add(e.id);
      }
    }
    }
    
    if(listCheckPriority != listOriginalPriority.value){
      loadingToday.value = true;
      UserRepository repoUsuario = UserRepositoryImpl();
      var currentUser = await repoUsuario.getCurrentUser();
      AssignChildRepository repo = AssignChildRepositoryImpl();
      bool responseSavePosition = await repo.savePositionForChildren(currentUser!.id, listAssignChildrenToday.value);
      getauthorizationsForToday();
    }
  }

  void changePriorityAction(int indexChild) {
    listAssignChildrenToday.value[indexChild].priorizado = !listAssignChildrenToday.value[indexChild].priorizado;
    var newValue = listAssignChildrenToday.value;
    listAssignChildrenToday.value = newValue;
    update();
  }

  @override
  void dispose(){
    tabBarcontroller.dispose();
    super.dispose();
  }
  
  Future closeSession() async {
    UserRepository repoUsuario = UserRepositoryImpl();
    QRRepository repoQR = QRRepositoryImpl();
    await repoUsuario.clearDataUser();
    await repoQR.clearQR();
    _authenticationController.signOut();
  }
}