import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/data/model/assign_child.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/assign_child_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/data/response/assignChild/assign_child_response.dart';
import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeChargeController extends GetxController with SingleGetTickerProviderMixin {

  final AuthenticationController _authenticationController = Get.find();
  var usuarioLogged = User().obs;
  var listAssignChildrenToday = List<AssignChildModel>.empty().obs;
  var listAssignChildrenProgram = List<AssignChildModel>.empty().obs;
  
  late TabController tabBarcontroller;

  final List<Tab> tabCharger = <Tab>[
    Tab(text: 'Hoy'),
    Tab(text: 'Programados'),
  ];

  @override
  void onInit(){
    super.onInit();
    getUserLogged();
    tabBarcontroller = TabController(length: tabCharger.length, vsync: this, initialIndex: 0);
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
    UserRepository repoUsuario = UserRepositoryImpl();
    var currentUser = await repoUsuario.getCurrentUser();
    AssignChildRepository repo = AssignChildRepositoryImpl();
    List<AssignChildModel>? list = await repo.getListAssignChildToday(currentUser!.id);
    if(list!=null){
      listAssignChildrenToday.value = list;
    }
    update();
    return list;
  }

  Future<List<AssignChildModel>> getauthorizationsForFuture() async {
    UserRepository repoUsuario = UserRepositoryImpl();
    var currentUser = await repoUsuario.getCurrentUser();
    AssignChildRepository repo = AssignChildRepositoryImpl();
    List<AssignChildModel>? list = await repo.getListAssignChildFuture(currentUser!.id);
    if(list!=null){
      listAssignChildrenProgram.value = list;
    }
    update();
    return list;
  }

  @override
  void dispose(){
    tabBarcontroller.dispose();
    super.dispose();
  }
  
  Future closeSession() async {
    _authenticationController.signOut();
    UserRepository repoUsuario = UserRepositoryImpl();
    await repoUsuario.clearDataUser();
  }
}