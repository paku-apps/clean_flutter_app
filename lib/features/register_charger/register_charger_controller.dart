
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterChargerController extends GetxController{

  bool isSubmitted = false;
  bool showChooseImage = false.obs();
  File? imageFileTaked = null.obs();

  final GlobalKey<FormState> regiterChargerFormkey = GlobalKey<FormState>().obs();
  late TextEditingController nameController, lastnameController, emailController, docController, passConytoller, repassController;



  @override 
  void onInit(){
    nameController = TextEditingController();
    lastnameController = TextEditingController();
    emailController = TextEditingController();
    docController = TextEditingController();
    passConytoller = TextEditingController();
    repassController = TextEditingController();
  }

  @override 
  void onReady(){
    super.onReady();
  }

  @override 
  void onClose(){
    nameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    docController.dispose();
    passConytoller.dispose();
    repassController.dispose();
  }


  takePicture() async {
    var imageTaked = await ImagePicker().pickImage(source: ImageSource.camera);
    if(imageTaked == null) return;
    imageFileTaked = File(imageTaked.path);
    update();
  }
  
  String? validateNombres(String value){
    if(GetUtils.isNullOrBlank(value)!){
      return "Ingresar nombres";
    }
    return null;
  }
  
}