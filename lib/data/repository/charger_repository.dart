import 'dart:convert';

import 'package:clean_app/data/converters/charger_model_from_carguer_response.dart';
import 'package:clean_app/data/model/charger.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/charger_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:http/http.dart' as http;

abstract class ChargerRepository {

  Future<List<Charger>> getListChargerSearch(String authToken, String pattern);

}

class ChargerRepositoryImpl extends ChargerRepository {
  static var client = http.Client();

  @override
  Future<List<Charger>> getListChargerSearch(String authToken, String pattern) async {
    var pathService = pathServer+stage+searchChargerService;
    //pathService = pathService.replaceAll(":1", idApoderado.toString());
    var url = Uri.parse(pathService);
    var response = await client.post(
      url, 
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $authToken"
      },      
      body: json.encode({
        "busqueda": pattern
      })
    );
    if(response.statusCode == 200){
      var jsonResponse = response.body;
      var decodedResponse = utf8.decode(response.bodyBytes);
      var resultResponse = apiResultResponseFromJson(decodedResponse);
      var dataResponse = chargerResponseFromJson(json.encode(resultResponse.data));
      return getListChargerResponseToListCharger(dataResponse);
    } else {
      throw ChargerRepositoryException(message: 'No se pudo parser Chargers');
    }
  }

}

class ChargerRepositoryException implements Exception {
  final String message;

  ChargerRepositoryException({this.message = 'Error en el repository Charger'});
}
