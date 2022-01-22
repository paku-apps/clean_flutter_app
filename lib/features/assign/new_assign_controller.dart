import 'package:clean_app/data/model/charger.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/assign_repository.dart';
import 'package:clean_app/data/repository/charger_repository.dart';
import 'package:clean_app/data/repository/child_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignController extends GetxController {

  var isSubmitted = false.obs();
  String tokenStored = "";
  
  final GlobalKey<FormState> assignFormKey = GlobalKey<FormState>().obs();
  late TextEditingController emailController, passwordController;
  var responsable = "".obs();
  var rangoFrecuenciaCadena = "".obs;
  var listChildren = List<Child>.empty().obs;
  var usuarioLogged = User().obs;

  //Data for Backend
  var rangeFrecuencyStart = "".obs;
  var rangeFrecuencyEnd = "".obs;
  var idCharger = 0.obs;
  var idApoderado = 0.obs;
  
  @override
  void onInit(){
    super.onInit();
    getUserLogged();
    getChildren();
  }

  Future<User?> getUserLogged() async {
    UserRepository repo = UserRepositoryImpl();
    var currentUser = await repo.getCurrentUser();
    if(currentUser!=null){
      usuarioLogged.value = currentUser;
      idApoderado.value = currentUser.id;
    }
    return currentUser;
  }
  
  @override 
  void onClose(){
    emailController.dispose();
    passwordController.dispose();
  }

  Future<List<Charger>> searchChargerByPattern(String pattern) async {
    UserRepository repoUsuario = UserRepositoryImpl();
    tokenStored = await repoUsuario.getToken();
    ChargerRepository repo = ChargerRepositoryImpl();
    List<Charger> list = await repo.getListChargerSearch(tokenStored, pattern);
    return list;
  }

  void checkChild(int position){
    listChildren.value[position].isChecked = !listChildren.value[position].isChecked;
    update();
  }
  
  Future<List<Child>?> getChildren() async {
    UserRepository repoUsuario = UserRepositoryImpl();
    tokenStored = await repoUsuario.getToken();
    ChildRepository repo = ChildRepositoryImpl();
    var idApoderado = usuarioLogged.value.id;
    List<Child>? list = await repo.getListChild(tokenStored, idApoderado);
    if(list!=null){
      listChildren.value = list;
    }
    update();
    return list;
    
  }

  void submitNewAssign() async {
    var listaChilds = listChildren.value;
    var start = this.rangeFrecuencyStart.value;
    var end = this.rangeFrecuencyEnd.value;
    var apoderado = this.idApoderado.value;
    var responsable = this.idCharger.value;
    this.tokenStored;

    var childrenSelected = listaChilds.where((child) => child.isChecked == true);
    var assignRepository = AssignRepositoryImpl();
    var responseSubmit = await assignRepository.submitAssign(this.tokenStored, responsable, apoderado, start, end, childrenSelected);


  }

}