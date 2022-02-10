import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/widgets/snackbars/snackbar_get_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EmailForgotController extends GetxController {

    
  bool isSubmitted = false;
  var isLoading = false.obs;  
  
  late GlobalKey<FormState> changeEmailForgot;
  late TextEditingController emailController;
  var email = "";

  
  @override 
  void onInit(){
    changeEmailForgot = GlobalKey<FormState>();
    emailController = TextEditingController();
  }

  
  @override 
  void onClose(){
    emailController.dispose();
  }

  
  String? validateEmail(String value){
    if(!GetUtils.isEmail(value)){
      return "Ingresar correo valido";
    }
    return null;
  }

  void checkEmail() async {
    isSubmitted = true;
    isLoading.value = true;
    update();
    final isValid = changeEmailForgot.currentState!.validate();
    if(!isValid){
      return;
    }
    changeEmailForgot.currentState!.save();
    submitResetEmail(emailController.text);
  }

  void submitResetEmail(String correo) async {
    var repo = UserRepositoryImpl();
      try{
        var validPassword = await repo.submitNewPasswordEmail(correo);
        if(validPassword == "Success"){    
          Get.back();
          showSuccessSnackbar("Correo Validado", "Por favor revise su correo");
        } 
        isLoading.value = false;
        update();
      } catch(e) {
        isLoading.value = false;
        showErrorSnackbar("Error al actualizar", "Por favor, intentelo en breves momentos");
        update();
      }
  }
}