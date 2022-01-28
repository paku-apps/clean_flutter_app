import 'dart:convert';

import 'package:clean_app/data/converters/assign_model_from_assign_response.dart';
import 'package:clean_app/data/model/assign.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/assign_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;

abstract class AssignRepository {

  Future<List<Assign>> getListAssignByApoderado(String authToken, int idApoderado);
  Future<String> submitAssign(String authToken, int responsable, int apoderado, String start, String end, Iterable<Child> childrenSelected);
  Future<String> updateAssign(String authToken, int idAssign, int responsable, int apoderado, String start, String end, Iterable<Child> childrenSelected);
  Future<String> deleteAssign(String authToken, int idAssign);
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
      if(response.statusCode == 500){ throw AssignRepositoryException(message: 'Ocurrió algo inesperado en nuestros servicios', code: 500);}
      if(response.statusCode == 401){ throw AssignRepositoryException(message: 'Por favor vuelva a iniciar sesión', code: 401);}
      throw AssignRepositoryException(message: 'Ocurrió algo inesperado en la aplicación', code: 401);
    }
  }

  @override
  Future<String> updateAssign(String authToken, int idAssign, int responsable, int apoderado, String start, String end, Iterable<Child> childrenSelected) async {
    var pathService = pathServer+stage+updateAssignService;
    pathService = pathService.replaceAll(":1", idAssign.toString());
    var url = Uri.parse(pathService);
    var response = await client.put(
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
      if(response.statusCode == 500){ throw AssignRepositoryException(message: 'Ocurrió algo inesperado en nuestros servicios', code: 500);}
      if(response.statusCode == 401){ throw AssignRepositoryException(message: 'Por favor vuelva a iniciar sesión', code: 401);}
      throw AssignRepositoryException(message: 'Ocurrió algo inesperado en la aplicación', code: 401);
    }
  }

  @override
  Future<String> deleteAssign(String authToken, int idAssign) async {
    var pathService = pathServer+stage+deleteAssignService+idAssign.toString();
    var url = Uri.parse(pathService);
    var response = await client.delete(
      url, 
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $authToken"
      },
    );
    if(response.statusCode == 200){
      var jsonResponse = response.body;
      var decodedResponse = utf8.decode(response.bodyBytes);
      var resultResponse = apiResultResponseFromJson(decodedResponse);
      if(resultResponse.status == true){
        print("Se eliminó la autorizacion");
        return "SUCCESS";
      } else {
        print("No se pudo eliminar la autorizacion");
        return "ERROR";
      }
    } else {
      if(response.statusCode == 500){ throw AssignRepositoryException(message: 'Ocurrió algo inesperado en nuestros servicios', code: 500);}
      if(response.statusCode == 401){ throw AssignRepositoryException(message: 'Por favor vuelva a iniciar sesión', code: 401);}
      throw AssignRepositoryException(message: 'Ocurrió algo inesperado en la aplicación', code: 401);
    }
  }

}

class AssignRepositoryException implements Exception {
  final String message;
  final int code;

  AssignRepositoryException({this.message = 'Error en el repository Assign', this.code = 404});
}
