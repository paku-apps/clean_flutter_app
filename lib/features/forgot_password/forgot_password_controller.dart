import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:clean_app/features/login/auth/authentication_service.dart';
import 'package:clean_app/features/login/auth/authentication_state.dart';
import 'package:clean_app/widgets/snackbars/snackbar_get_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {

   
  final AuthenticationController _authenticationController = Get.find();
  
  bool isSubmitted = false;
  var isLoading = false.obs();  
  
  late GlobalKey<FormState> changePasswordFormKey;
  late TextEditingController firstPasswordController, secondPasswordController;
  var password = "";
  var repassword = "";



  @override 
  void onInit(){
    changePasswordFormKey = GlobalKey<FormState>();
    firstPasswordController = TextEditingController();
    secondPasswordController = TextEditingController();
  }

  
  @override 
  void onClose(){
    firstPasswordController.dispose();
    secondPasswordController.dispose();
  }

  String? validatePass(String value){
    if(!GetUtils.isLengthGreaterOrEqual(value, 6)){
      return "Ingresar un mínimo de 6 carácteres";
    }
    return null;
  }

  String? validateRePass(String value){
    if(value != firstPasswordController.text){
      return "Las contraseñas deben de coincidir";
    }
    return null;
  }

  void checkNewPassword(){
    isSubmitted = true;
    update();
    final isValid = changePasswordFormKey.currentState!.validate();
    if(!isValid){
      return;
    }
    changePasswordFormKey.currentState!.save();
    submitNewPassowrd(firstPasswordController.text, secondPasswordController.text);
  }

  void submitNewPassowrd(String text, String text2) async {
    var repo = UserRepositoryImpl();
    var user = await repo.getCurrentUser();
    if(user!=null){
      try{
        //await repo.submitNewPassword(user.id, text);
        isLoading = false;
        _authenticationController.updateToPasswordSignIn(user);
        showSuccessSnackbar("Bienvenido", "Colegio Villa Maria te saluda");
      } catch(e) {
        isLoading = false;
        showErrorSnackbar("Error al actualizar", "Por favor, intentelo en breves momentos");
        update();
      }
    }
  }

}