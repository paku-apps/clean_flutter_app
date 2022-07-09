
import 'dart:io';

import 'package:clean_app/data/repository/charger_repository.dart';
import 'package:clean_app/widgets/snackbars/snackbar_get_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterChargerController extends GetxController{

  bool isSubmitted = false;
  bool showChooseImage = false.obs();
  File? imageFileTaked = null.obs();
  var isLoading = false.obs();

  late GlobalKey<FormState> regiterChargerFormkey;
  late TextEditingController nameController, lastnamePaternoController, lastnameMaternoController, emailController, docController, passConytoller, repassController;
  var nombres = "";
  var appaterno = "";
  var apmaterno = "";
  var correo = "";
  var documento = "";
  var pass = "";
  var repass = "";


  @override 
  void onInit(){
    regiterChargerFormkey = GlobalKey<FormState>();
    nameController = TextEditingController();
    lastnamePaternoController = TextEditingController();
    lastnameMaternoController = TextEditingController();
    emailController = TextEditingController();
    docController = TextEditingController();
    passConytoller = TextEditingController();
    repassController = TextEditingController();
  }


  @override 
  void onClose(){
    nameController.dispose();
    lastnamePaternoController.dispose();
    lastnameMaternoController.dispose();
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
      return "Debe ingresar este campo";
    }
    return null;
  }

  String? validateEmail(String value){
    if(!GetUtils.isEmail(value)){
      return "Ingresar un correo válido";
    }
    return null;
  }

  String? validateDoc(String value){
    if(!GetUtils.isLengthGreaterOrEqual(value, 8)){
      return "Ingresar un mínimo de 8 carácteres";
    }
    return null;
  }

  String? validatePass(String value){
    if(!GetUtils.isLengthGreaterOrEqual(value, 6)){
      return "Ingresar un mínimo de 6 carácteres";
    }
    return null;
  }

  String? validateRePass(String value){
    if(value != passConytoller.text){
      return "Las contraseñas deben de coincidir";
    }
    return null;
  }

  void checkToRegister(){
    isSubmitted = true;
    update();
    final isValid = regiterChargerFormkey.currentState!.validate();
    if(!isValid){
      return;
    }
    regiterChargerFormkey.currentState!.save();
    registerCharger(nameController.text, lastnamePaternoController.text,  lastnameMaternoController.text, emailController.text, docController.text, passConytoller.text, repassController.text);
  }

  void registerCharger(String username, String paterno, String materno, String email, String numDoc, String pass, String repass) async {
    isLoading = true;

    try{
      var chargerRepository = ChargerRepositoryImpl();
      await chargerRepository.submitCharger(username, paterno, materno, email, numDoc, pass);
      isLoading = false;
      Get.back();
      Get.back();
      showSuccessSnackbar("Bienvenido", "Colegio Villa Maria te saluda");
    } catch(e) {
      isLoading = false;
      Get.back();
      Get.back();
      showErrorSnackbar("Error al registrar", "Por favor, intentelo en breves momentos");
      update();
    }
  }

  
}