import 'dart:convert';

import 'package:clean_app/data/converters/assign_child_model_from_assign_response.dart';
import 'package:clean_app/data/model/assign_child.dart';
import 'package:clean_app/data/model/child_request.dart';
import 'package:clean_app/data/repository/charger_repository.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/assignChild/assign_child_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/services/dio_services.dart';

abstract class AssignChildRepository {

  Future<List<AssignChildModel>> getListAssignChildToday(int idApoderado);
  Future<List<AssignChildModel>> getListAssignChildFuture(int idApoderado);
  Future<bool> savePositionForChildren(int idApoderado, List<AssignChildModel> listChildPriority);
}

class AssignChildRepositoryImpl extends AssignChildRepository {
  
  static HttpDioService httpService = HttpDioService();

  @override
  Future<List<AssignChildModel>> getListAssignChildToday(int idApoderado) async {
    httpService.init();
    var pathService = pathServer+stage+listAssignChildToday;
    pathService = pathService.replaceAll(":1", idApoderado.toString());
    
    try {
      var response = await httpService.request(
        method: Method.GET,
        url: pathService,
      );
      if(response.statusCode == 200){

        var apiResultResponse =  ApiResultResponse.fromJson(response.data);
        var dataResponse = assignChildFromJson((json.encode(apiResultResponse.data)));
        return getListAssignChildResponseToListAssignChild(dataResponse);
        
      } else {
        throw AssignChildRepositoryException(message: 'Error en el repository List Assign-Child');
      }
    } catch (e){
      throw AssignChildRepositoryException(message: 'Error en el repository List Assign-Child');
    }

  }

  @override
  Future<List<AssignChildModel>> getListAssignChildFuture(int idApoderado) async {
   httpService.init();
    var pathService = pathServer+stage+listAssignChildFuture;
    pathService = pathService.replaceAll(":1", idApoderado.toString());
    
    try {
      var response = await httpService.request(
        method: Method.GET,
        url: pathService,
      );
      if(response.statusCode == 200){

        var apiResultResponse =  ApiResultResponse.fromJson(response.data);
        var dataResponse = assignChildFromJson((json.encode(apiResultResponse.data)));
        return getListAssignChildResponseToListAssignChild(dataResponse);
        
      } else {
        throw AssignChildRepositoryException(message: 'Error en el repository List Assign-Child');
      }
    } catch (e){
      throw AssignChildRepositoryException(message: 'Error en el repository List Assign-Child');
    }
  }

  
  @override
  Future<bool> savePositionForChildren(int idApoderado, List<AssignChildModel> listChildPriority) async {
    httpService.init();
    var pathService = pathServer+stage+setPriority;
    pathService = pathService.replaceAll(":1", idApoderado.toString());

    try {
      var response = await httpService.request(
        method: Method.POST,
        url: pathService,
        params: {
          "estudiantes": requestChildPriorityToJson(listChildPriority)
        }
      );
      if(response.statusCode == 200){
        return true;
      } else {
        throw ChargerRepositoryException(message: 'Error en el repository Charger');
      }
    } catch (e){
      throw ChargerRepositoryException(message: 'Error en el repository Charger');
    }
  }

}

class AssignChildRepositoryException implements Exception {
  final String message;
  final int code;

  AssignChildRepositoryException({this.message = 'Error en el repository AssignChild', this.code = 404});
}
