import 'dart:convert';

import 'package:clean_app/data/model/assign.dart';
import 'package:clean_app/data/repository/assign_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/widgets/snackbars/snackbar_get_utils.dart';
import 'package:get/get.dart';

class DetailAssignController extends GetxController {

  void goToUpdateAssign(Map<String, dynamic> assign) {
    Get.toNamed(AppLinks.NEW_ASSIGN, arguments: [json.encode(Assign.fromJson(assign))]);
  }

  Future<void> deleteAssign(Map<String, dynamic> assign) async {
    var assignEntity = Assign.fromJson(assign);
    UserRepository repoUsuario = UserRepositoryImpl();
    var tokenStored = await repoUsuario.getToken();
    var assignRepository = AssignRepositoryImpl();
    try{
      var responseUpdated = await assignRepository.deleteAssign(tokenStored, assignEntity.id!);
      Get.offAllNamed(AppLinks.LIST_ASSIGNS);
      showSuccessSnackbar("Se eliminó la autorización", "Se le notificará al responsable");
    } on AssignRepositoryException catch(e){
      showErrorSnackbar("Aviso", e.message);
    }
  }
  
}