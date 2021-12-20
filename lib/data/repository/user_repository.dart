import 'dart:convert';

import 'package:clean_app/data/converters/user_model_from_user_response.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/response/auth/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository {

  Future<bool?> isUserLogged();
  Future<User?> getCurrentUser();
  Future<void> saveUser(UserBd user);

}

class UserRepositoryImpl extends UserRepository {

  final keyUserApp = "SP_KEY_APP";

  @override
  Future<User?> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userLogged = prefs.getString(keyUserApp);
    if(userLogged!=null){
      return getUserFromUserResponse(UserBd.fromJson(jsonDecode(userLogged)));
    }
    return User();
  }

  @override
  Future<bool?> isUserLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userLogged = prefs.getString(keyUserApp);
    return userLogged!=null;
  }

  @override
  Future<void> saveUser(UserBd user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userLogged = prefs.setString(keyUserApp, user.toJson().toString());
  }
}