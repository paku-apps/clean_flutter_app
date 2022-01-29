import 'dart:convert';

import 'package:clean_app/data/converters/charger_model_from_carguer_response.dart';
import 'package:clean_app/data/model/charger.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/charger_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/services/dio_services.dart';
import 'package:http/http.dart' as http;

abstract class ChargerRepository {

  Future<List<Charger>> getListChargerSearch(String authToken, String pattern);

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

}

class ChargerRepositoryException implements Exception {
  final String message;

  ChargerRepositoryException({this.message = 'Error en el repository Charger'});
}
