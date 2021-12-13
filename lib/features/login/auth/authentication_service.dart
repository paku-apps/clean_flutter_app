import 'package:clean_app/data/model/user.dart';
import 'package:get/get.dart';

abstract class AuthenticationService extends GetxService {

  Future<User?> getCurrentUser();
  Future<User> signInEmailAndPassword(String username, String password);
  Future<void> signOut();

}

class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<User?> getCurrentUser() async {
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  Future<User> signInEmailAndPassword(String username, String password) async {
    
    await Future.delayed(Duration(seconds: 2));

    if (username.toLowerCase() != 'test@domain.com' || password != 'testpass123') {
      throw AuthenticationException(message: 'Wrong username or password');
    }

    return User('Test User','LastanmeTest ', "test@email.com");

  }

  @override
  Future<void> signOut() async {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}