import 'dart:convert';

import 'package:clean_app/data/converters/assign_model_from_assign_response.dart';
import 'package:clean_app/data/model/assign.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/assign_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:http/http.dart' as http;

abstract class AssignRepository {

  Future<List<Assign>> getListAssignByApoderado(String authToken, int idApoderado);

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

}

class AssignRepositoryException implements Exception {
  final String message;

  AssignRepositoryException({this.message = 'Error en el repository Assign'});
}
