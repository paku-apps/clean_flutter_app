import 'dart:convert';

import 'package:clean_app/data/converters/assign_model_from_assign_response.dart';
import 'package:clean_app/data/model/assign.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/assign_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/services/dio_services.dart';
import 'package:http/http.dart' as http;

abstract class AssignRepository {

  Future<List<Assign>> getListAssignByApoderado(String authToken, int idApoderado);
  Future<String> submitAssign(String authToken, int responsable, int apoderado, String start, String end, Iterable<Child> childrenSelected);
  Future<String> updateAssign(String authToken, int idAssign, int responsable, int apoderado, String start, String end, Iterable<Child> childrenSelected);
  Future<String> deleteAssign(String authToken, int idAssign);
}

class AssignRepositoryImpl extends AssignRepository {
  static var client = http.Client();
  static HttpDioService httpService = HttpDioService();

  @override
  Future<List<Assign>> getListAssignByApoderado(String authToken, int idApoderado) async {

    httpService.init();
    var pathService = pathServer+stage+listAssignService;
    pathService = pathService.replaceAll(":1", idApoderado.toString());
    
    try {
      var response = await httpService.request(
        method: Method.GET,
        url: pathService,
      );
      if(response.statusCode == 200){

        var apiResultResponse =  ApiResultResponse.fromJson(response.data);
        var dataResponse = assignResponseFromJson(json.encode(apiResultResponse.data));
        return getListAssignResponseToListAssign(dataResponse);
        
      } else {
        throw AssignRepositoryException(message: 'Error en el repository Get List Assign');
      }
    } catch (e){
      throw AssignRepositoryException(message: 'Error en el repository Get List Assign');
    }

  }

  @override
  Future<String> submitAssign(String authToken, int responsable, int apoderado, String start, String end, Iterable<Child> childrenSelected) async {
       
    httpService.init();
    var pathService = pathServer+stage+createNewAssignService;
    
    try {
      var response = await httpService.request(
        method: Method.POST,
        url: pathService,
        params: {
          "id_autorizado" : responsable,
          "id_apoderado": apoderado,
          "fecha_inicio": start,
          "fecha_fin": end,
          "estudiantes": childSelectedToJson(childrenSelected.toList())
        }
      );
      if(response.statusCode == 200){

        var apiResultResponse =  ApiResultResponse.fromJson(response.data);
        if(apiResultResponse.status == true){
          return "SUCCESS";
        } else {
          return "ERROR";
        }

      } else {
        throw AssignRepositoryException(message: 'Error en el repository Submit Assign');
      }
    } catch (e){
      throw AssignRepositoryException(message: 'Error en el repository Submit Assign');
    }
  }

  @override
  Future<String> updateAssign(String authToken, int idAssign, int responsable, int apoderado, String start, String end, Iterable<Child> childrenSelected) async {

    httpService.init();
    var pathService = pathServer+stage+updateAssignService;
    pathService = pathService.replaceAll(":1", idAssign.toString());
    
    try {
      var response = await httpService.request(
        method: Method.PUT,
        url: pathService,
        params: {
          "id_autorizado" : responsable,
          "id_apoderado": apoderado,
          "fecha_inicio": start,
          "fecha_fin": end,
          "estudiantes": childSelectedToJson(childrenSelected.toList())
        }
      );
      if(response.statusCode == 200){

        var apiResultResponse =  ApiResultResponse.fromJson(response.data);
        if(apiResultResponse.status == true){
          return "SUCCESS";
        } else {
          return "ERROR";
        }
        
      } else {
        throw AssignRepositoryException(message: 'Error en el repository Update Assign');
      }
    } catch (e){
      throw AssignRepositoryException(message: 'Error en el repository Update Assign');
    }
  }

  @override
  Future<String> deleteAssign(String authToken, int idAssign) async {

    httpService.init();
    var pathService = pathServer+stage+deleteAssignService+idAssign.toString();
    
    try {
      var response = await httpService.request(
        method: Method.DELETE,
        url: pathService
      );
      if(response.statusCode == 200){

        var apiResultResponse =  ApiResultResponse.fromJson(response.data);
        if(apiResultResponse.status == true){
          print("Se eliminó la autorizacion");
          return "SUCCESS";
        } else {
          print("No se pudo eliminar la autorizacion");
          return "ERROR";
        }
        
      } else {
        throw AssignRepositoryException(message: 'Error en el repository Update Assign');
      }
    } catch (e){
      throw AssignRepositoryException(message: 'Error en el repository Update Assign');
    }
  }

}

class AssignRepositoryException implements Exception {
  final String message;
  final int code;

  AssignRepositoryException({this.message = 'Error en el repository Assign', this.code = 404});
}
