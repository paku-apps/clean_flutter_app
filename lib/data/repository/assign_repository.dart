import 'dart:convert';

import 'package:clean_app/data/converters/assign_model_from_assign_response.dart';
import 'package:clean_app/data/model/assign.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/assign_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;

abstract class AssignRepository {

  Future<List<Assign>> getListAssignByApoderado(String authToken, int idApoderado);
  Future<String> submitAssign(String authToken, int responsable, int apoderado, String start, String end, Iterable<Child> childrenSelected);

}

class AssignRepositoryImpl extends AssignRepository {
  static var client = http.Client();

  @override
  Future<List<Assign>> getListAssignByApoderado(String authToken, int idApoderado) async {
    var pathService = pathServer+stage+listAssignService;
    pathService = pathService.replaceAll(":1", idApoderado.toString());
    var url = Uri.parse(pathService);
    var response = await client.get(
      url, 
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $authToken"
      }
    );
    if(response.statusCode == 200){
      var jsonResponse = response.body;
      var decodedResponse = utf8.decode(response.bodyBytes);
      var resultResponse = apiResultResponseFromJson(decodedResponse);
      var dataResponse = assignResponseFromJson(json.encode(resultResponse.data));
      return getListAssignResponseToListAssign(dataResponse);
    } else {
      throw AssignRepositoryException(message: 'No se pudo parser Children');
    }

  }

  @override
  Future<String> submitAssign(String authToken, int responsable, int apoderado, String start, String end, Iterable<Child> childrenSelected) async {
    var pathService = pathServer+stage+createNewAssignService;
    var url = Uri.parse(pathService);
    var response = await client.post(
      url, 
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $authToken"
      },
      body: json.encode({
        "id_autorizado" : responsable,
        "id_apoderado": apoderado,
        "fecha_inicio": start,
        "fecha_fin": end,
        "estudiantes": childSelectedToJson(childrenSelected.toList())
      })
    );
    if(response.statusCode == 200){
      var jsonResponse = response.body;
      var decodedResponse = utf8.decode(response.bodyBytes);
      var resultResponse = apiResultResponseFromJson(decodedResponse);
      if(resultResponse.status == true){
        return "SUCCESS";
      } else {
        return "ERROR";
      }
    } else {
      throw AssignRepositoryException(message: 'No se pudo parser Assign');
    }
  }

}

class AssignRepositoryException implements Exception {
  final String message;

  AssignRepositoryException({this.message = 'Error en el repository Assign'});
}
