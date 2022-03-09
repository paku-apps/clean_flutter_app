import 'package:clean_app/features/login/auth/authentication_service.dart';
import 'package:clean_app/features/login/auth/authentication_state.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {

  final AuthenticationService _authenticationService;

  final _authenticationStateStream = AuthenticationState().obs;

  AuthenticationState get state => _authenticationStateStream.value;

  AuthenticationController(this._authenticationService);

  @override
  void onInit() {
    _getAuthenticatedUser();
    super.onInit();
  }

  Future<String> signIn(String username, String password, bool rememberAccount) async {
    var user = await _authenticationService.signInEmailAndPassword(username, password, rememberAccount);
    if(user.reseteo==false){
      _authenticationStateStream.value = Authenticated(user: user);
      return "SUCCESS";
    } else {
      _authenticationStateStream.value = UnAuthenticated();

    }
    return "PASSWORD";
  }

  void updateToPasswordSignIn(user) async {
    _authenticationStateStream.value = Authenticated(user: user);
  }

  void signOut() async {
    await _authenticationService.signOut();
    _authenticationStateStream.value = UnAuthenticated();
  }


  void _getAuthenticatedUser() async {
    _authenticationStateStream.value = AuthenticationLoading();

    final user = await _authenticationService.getCurrentUser();

    if(user == null){
      _authenticationStateStream.value = UnAuthenticated();
    } else {
      _authenticationStateStream.value = Authenticated(user: user);
    }
  }

}