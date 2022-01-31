import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:clean_app/features/login/auth/authentication_service.dart';
import 'package:clean_app/features/login/login_state.dart';
import 'package:clean_app/widgets/snackbars/snackbar_get_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  final AuthenticationController _authenticationController = Get.find();

  late GlobalKey<FormState> loginFormkey;
  late TextEditingController emailController, passwordController;
  var isLoading = false.obs();
  var email = "";
  var password = "";
  var isSubmitted = false;
  var loginSuccessfull = false.obs();

  //To Validate show or hide the password
  bool _showPassword = false;
  bool get passVisibility => _showPassword;

  void changePassVisibility(){
    _showPassword = !_showPassword;
    update();
  }

  @override 
  void onInit(){
    loginFormkey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override 
  void onReady(){
    super.onReady();
  }

  @override 
  void onClose(){
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String value){
    if(!GetUtils.isEmail(value)){
      return "Ingresar un Email Valido";
    }
    return null;
  }

  String? validatePassword(String value){
    if(value.length<6){
      return "Contraseña debe tener al menos 6 caracteres";
    }
    return null;
  }

  void checkLogin(){
    isSubmitted = true;
    update();
    final isValid = loginFormkey.currentState!.validate();
    if(!isValid){
      return;
    }
    loginFormkey.currentState!.save();
    login(emailController.text, passwordController.text);
  }

  

  final _loginStateStream = LoginState().obs;

  LoginState get state => _loginStateStream.value;

  void login(String username, String password) async {
    _loginStateStream.value = LoginLoading();
    isLoading = true;

    try{
      await _authenticationController.signIn(username, password);
      _loginStateStream.value = LoginState();
      isLoading = false;
      showSuccessSnackbar("Bienvenido", "Colegio Villa Maria los saluda");
    } on AuthenticationException catch(e) {
      _loginStateStream.value = LoginFailure(error: e.message);
      isLoading = false;
      showErrorSnackbar("Ingreso fallido", "Por favor, verifique su usuario y contraseña");
      update();
    }
  }

}