import 'dart:convert';

import 'package:clean_app/data/model/assign.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:get/get.dart';

class DetailAssignController extends GetxController {

  


  void goToUpdateAssign(Map<String, dynamic> assign) {
    Get.toNamed(AppLinks.NEW_ASSIGN, arguments: [json.encode(Assign.fromJson(assign))]);
  }

  Future<bool> deleteAssign() async {
    return true;
  }
  
}