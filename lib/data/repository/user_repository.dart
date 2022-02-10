import 'dart:convert';

import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/converters/user_model_from_user_response.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/auth/user_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/services/dio_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository {

  Future<bool?> isUserLogged();
  Future<User?> getCurrentUser();
  Future<void> saveUser(UserBd user);
  Future<void> saveToken(String idToken);
  Future<String> getToken();
  Future<void> saveRefreshToken(String refreshToken);
  Future<String> getRefreshToken();
  Future<void> clearDataUser();
  Future<String> submitNewPassword(int idUsuario, String newPassword);
  Future<void> saveAuxiliarUser(UserBd user);
  Future<UserBd?> getAuxiliarUser();

}

class UserRepositoryImpl extends UserRepository {

  final keyUserApp = "SP_KEY_APP";
  final keyIdToken = "SP_KEY_APP_TOKEN";
  final keyRefreshToken = "SP_KEY_APP_REFRESH_TOKEN";
  final keyAuxiliarUser = "SP_KEY_AUXILIAR_USER";

  static final UserRepositoryImpl _singleton = UserRepositoryImpl._internal();

  factory UserRepositoryImpl() {
    return _singleton;
  }

  UserRepositoryImpl._internal();

  @override
  Future<User?> getCurrentUser() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userLogged = prefs.getString(keyUserApp);
    if(userLogged!=null){
      Map<String, dynamic> jsonBody = jsonDecode(userLogged);
      return getUserFromUserBD(UserBd.fromJson(jsonBody));
    }
    return null;
  }

  @override
  Future<bool?> isUserLogged() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userLogged = prefs.getString(keyUserApp);
    return userLogged!=null;
  }

  @override
  Future<void> saveUser(UserBd user) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //jsonEncode(user);
    var userLogged = prefs.setString(keyUserApp, jsonEncode(user));
  }

  @override
  Future<void> saveToken(String idToken) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userLogged = prefs.setString(keyIdToken, idToken);

  }

  @override
  Future<void> clearDataUser() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Future<String> getToken() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idTokenStored = prefs.getString(keyIdToken);
    if(idTokenStored!=null){
      return idTokenStored;
    }
    return emptyString;
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyRefreshToken, refreshToken);
  }

  @override
  Future<String> getRefreshToken() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var refreshToken = prefs.getString(keyRefreshToken);
    if(refreshToken!=null){
      return refreshToken;
    }
    return emptyString;
  }

  
 @override
  Future<void> saveAuxiliarUser(UserBd user) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //jsonEncode(user);
    var userLogged = prefs.setString(keyAuxiliarUser, jsonEncode(user));
  }

  @override
  Future<UserBd?> getAuxiliarUser() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userLogged = prefs.getString(keyAuxiliarUser);
    if(userLogged!=null){
      Map<String, dynamic> jsonBody = jsonDecode(userLogged);
      return UserBd.fromJson(jsonBody);
    }
    return null;
  }

  @override
  Future<String> submitNewPassword(int? idUsuario, String newPass) async {

    HttpDioService httpService = HttpDioService();
    httpService.init();

    var userLogged = User();
    var url = pathServer+stage+submitPathNewPassword;
    url = url.replaceAll(":1", idUsuario.toString());

    try {
      var response = await httpService.request(
        url: url,
        method: Method.PUT,
        params: {
          "password": newPass
        }
      );
      if(response.statusCode == 200){
        var apiResultResponse = ApiResultResponse.fromJson(response.data);
        return "Success";
      } else {
        throw UserRepositoryException(message: 'No se pudo registrar al usuario');
      }
    } catch (e){
      throw UserRepositoryException(message: 'No se pudo registrar al autorizado');
    }

  }

  @override
  Future<String> submitNewPasswordEmail(String email) async {

    HttpDioService httpService = HttpDioService();
    httpService.init();

    var userLogged = User();
    var url = pathServer+stage+submitPasswordToEmail;

    try {
      var response = await httpService.request(
        url: url,
        method: Method.POST,
        params: {
          "correo": email
        }
      );
      if(response.statusCode == 200){
        var apiResultResponse = ApiResultResponse.fromJson(response.data);
        return "Success";
      } else {
        throw UserRepositoryException(message: 'No se pudo recuperar la contraseña');
      }
    } catch (e){
      throw UserRepositoryException(message: 'No se pudo recuperar la contraseña');
    }

  }

  
}

class UserRepositoryException implements Exception {
  final String message;

  UserRepositoryException({this.message = 'Error en el repository de Usuario'});
}
