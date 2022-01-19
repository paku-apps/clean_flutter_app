import 'dart:convert';

import 'package:clean_app/data/converters/user_model_from_user_response.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/auth/authentication_data.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationService extends GetxService {

  Future<User?> getCurrentUser();
  Future<User> signInEmailAndPassword(String username, String password);
  Future<void> signOut();

}

class AuthenticationServiceImpl extends AuthenticationService {
  static var client = http.Client();

  @override
  Future<User> signInEmailAndPassword(String username, String password) async {
    
    var userLogged = User();
    var url = Uri.parse(pathServer+stage+loginService);
    var response = await client.post(
      url, 
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "username": username,
        "password": password
      })
    );
    if(response.statusCode == 200){
      UserRepository repo = UserRepositoryImpl();
      var jsonResponse = response.body;
      var appResponse = apiResultResponseFromJson(jsonResponse);
      var dataResponse = AuthenticationData.fromJson(appResponse.data);
      await repo.saveToken(dataResponse.authenticationResult.idToken);
      userLogged =  getUserFromUserBD(dataResponse.userBd);
      await repo.saveUser(dataResponse.userBd);
    } else {
      throw AuthenticationException(message: 'Wrong username or password');
    }

    return userLogged;
  }

  
  @override
  Future<User?> getCurrentUser() async {
    UserRepository repo = UserRepositoryImpl();
    return await repo.getCurrentUser();
    //await Future.delayed(Duration(seconds: 2));
    //return null;
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