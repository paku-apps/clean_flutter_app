import 'dart:convert';
import 'dart:io';

import 'package:clean_app/data/model/assign.dart';
import 'package:clean_app/data/repository/assign_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/widgets/snackbars/snackbar_get_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DetailAssignController extends GetxController {

  var isLoading = false.obs;

  void goToUpdateAssign(Map<String, dynamic> assign) {
    Get.toNamed(AppLinks.NEW_ASSIGN, arguments: [json.encode(Assign.fromJson(assign))]);
  }

  Future<void> deleteAssign(Map<String, dynamic> assign) async {
    isLoading.value = true;
    var assignEntity = Assign.fromJson(assign);
    UserRepository repoUsuario = UserRepositoryImpl();
    var tokenStored = await repoUsuario.getToken();
    var assignRepository = AssignRepositoryImpl();
    try{
      //var responseUpdated = await assignRepository.deleteAssign(tokenStored, assignEntity.id!);
      await Future.delayed(Duration(seconds: 2));
      //Get.offAndToNamed(AppLinks.LIST_ASSIGNS);
      Get.back();
      Get.back();
      isLoading.value = false;
      showSuccessSnackbar("Se eliminó la autorización", "Se le notificará al responsable");
    } on AssignRepositoryException catch(e){
      isLoading.value = false;
      showErrorSnackbar("Aviso", e.message);
    }
  }
  
}