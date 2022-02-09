import 'dart:convert';

import 'package:clean_app/data/converters/charger_model_from_carguer_response.dart';
import 'package:clean_app/data/model/charger.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/auth/authentication_data.dart';
import 'package:clean_app/data/response/charger_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/services/dio_services.dart';
import 'package:http/http.dart' as http;

abstract class ChargerRepository {

  Future<List<Charger>> getListChargerSearch(String authToken, String pattern);
  Future<String> submitCharger(String name, String paterno, String materno, String email, String numdoc, String pass);

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
  Future<String> submitCharger(String name, String paterno, String materno, String email, String numdoc, String pass) async {

    HttpDioService httpService = HttpDioService();
    httpService.init();

    var userLogged = User();
    var url = pathServer+stage+registerCharger;

    try {
      var response = await httpService.request(
        url: url,
        method: Method.POST,
        params: {
          "nombres": name,
          "ap_paterno": paterno,
          "ap_materno": materno,
          "correo": email,
          "numero_documento": numdoc,
          "password": pass
        }
      );
      if(response.statusCode == 200){
        var apiResultResponse = ApiResultResponse.fromJson(response.data);
        var dataResponse = AuthenticationData.fromJson(apiResultResponse.data);
        return "Success";
      } else {
        throw ChargerRepositoryException(message: 'No se pudo registrar al usuario');
      }
    } catch (e){
      throw ChargerRepositoryException(message: 'No se pudo registrar al autorizado');
    }
  }

}

class ChargerRepositoryException implements Exception {
  final String message;

  ChargerRepositoryException({this.message = 'Error en el repository Charger'});
}
