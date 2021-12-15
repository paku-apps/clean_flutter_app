import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:clean_app/features/login/auth/authentication_service.dart';
import 'package:clean_app/features/login/login_state.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  final AuthenticationController _authenticationController = Get.find();


  bool _showPassword = false;

  bool get passVisibility => _showPassword;

  void changePassVisibility(){
    _showPassword = !_showPassword;
    update();
  }

  final _loginStateStream = LoginState().obs;

  LoginState get state => _loginStateStream.value;

  void login(String username, String password) async {
    _loginStateStream.value = LoginLoading();

    try{
      await _authenticationController.signIn(username, password);
      _loginStateStream.value = LoginState();
    } on AuthenticationException catch(e) {
      _loginStateStream.value = LoginFailure(error: e.message);
    }
  }

}