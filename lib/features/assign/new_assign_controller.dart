import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AssignController extends GetxController {

  var isSubmitted = false.obs();
  
  final GlobalKey<FormState> loginFormkey = GlobalKey<FormState>().obs();
  late TextEditingController emailController, passwordController;
  var responsable = "".obs();

  
  @override 
  void onInit(){
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

    @override 
  void onClose(){
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateResponsable(String value){
    if(value.length<=6){
      return "Contraseña debe tener al menos 6 caracteres";
    }
    return null;
  }



}