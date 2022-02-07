import 'dart:convert';

import 'package:clean_app/data/converters/charger_model_from_carguer_response.dart';
import 'package:clean_app/data/model/charger.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/charger_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/services/dio_services.dart';
import 'package:http/http.dart' as http;

abstract class ChargerRepository {

  Future<List<Charger>> getListChargerSearch(String authToken, String pattern);
  Future<User?> submitCharger(String name, String lastName, String email, String numdoc, String pass, String repass);

 }

class ChargerRepositoryImpl extends ChargerRepository {
  static var client = http.Client();

  @override
  Future<List<Charger>> getListChargerSearch(String authToken, String pattern) async {

    HttpDioService httpService = HttpDioService();
    httpService.init();
    var pathService = pathServer+stage+searchChargerService;
    
    try {
      var response = await httpService.request(
        method: Method.POST,
        url: pathService,
        params: {
          "busqueda": pattern
        }
      );
      if(response.statusCode == 200){

        var apiResultResponse =  ApiResultResponse.fromJson(response.data);
        var dataResponse = chargerResponseFromJson(json.encode(apiResultResponse.data));
        return getListChargerResponseToListCharger(dataResponse);

      } else {
        throw ChargerRepositoryException(message: 'Error en el repository Charger');
      }
    } catch (e){
      throw ChargerRepositoryException(message: 'Error en el repository Charger');
    }
  }

  @override
  Future<User?> submitCharger(String name, String lastName, String email, String numdoc, String pass, String repass) async {

    HttpDioService httpService = HttpDioService();
    httpService.init();

    var userLogged = User();
    var url = pathServer+stage+loginService;

    /*
    try {
      var response = await httpService.request(
        url: url,
        method: Method.POST,
        params: {
          "username": username,
          "password": password
        }
      );
      if(response.statusCode == 200){
        UserRepository repo = UserRepositoryImpl();
        var apiResultResponse = ApiResultResponse.fromJson(response.data);
        var dataResponse = AuthenticationData.fromJson(apiResultResponse.data);
        await repo.saveToken(dataResponse.authenticationResult.idToken);
        await repo.saveRefreshToken(dataResponse.authenticationResult.refreshToken);
        userLogged =  getUserFromUserBD(dataResponse.userBd);
        await repo.saveUser(dataResponse.userBd);
      } else {
        throw AuthenticationException(message: 'Wrong username or password');
      }
    } catch (e){
      throw AuthenticationException(message: 'Wrong username or password');
    }*/
  }

}

class ChargerRepositoryException implements Exception {
  final String message;

  ChargerRepositoryException({this.message = 'Error en el repository Charger'});
}
