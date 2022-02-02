import 'dart:convert';

import 'package:clean_app/data/converters/assign_child_model_from_assign_response.dart';
import 'package:clean_app/data/model/assign_child.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/assignChild/assign_child_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/services/dio_services.dart';

abstract class AssignChildRepository {

  Future<List<AssignChildModel>> getListAssignChildToday(int idApoderado);
  Future<List<AssignChildModel>> getListAssignChildFuture(int idApoderado);
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

}

class AssignChildRepositoryException implements Exception {
  final String message;
  final int code;

  AssignChildRepositoryException({this.message = 'Error en el repository AssignChild', this.code = 404});
}
