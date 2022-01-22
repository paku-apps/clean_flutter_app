import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeChargeController extends GetxController with SingleGetTickerProviderMixin {

  final AuthenticationController _authenticationController = Get.find();
  var listChildrenToday = List<Child>.empty().obs;
  var listChildrenProgram = List<Child>.empty().obs;
  
  late TabController tabBarcontroller;

  final List<Tab> tabCharger = <Tab>[
    Tab(text: 'Hoy'),
    Tab(text: 'Programados'),
  ];

  @override
  void onInit(){
    super.onInit();
    tabBarcontroller = TabController(length: tabCharger.length, vsync: this, initialIndex: 0);
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