import 'dart:convert';

import 'package:clean_app/data/converters/list_child_model_from_child_response.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/child/child_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/services/dio_services.dart';
import 'package:http/http.dart' as http;

abstract class ChildRepository {

  Future<List<Child>?> getListChild(String authToken, int idApoderado);

}

class ChildRepositoryImpl extends ChildRepository {
  static var client = http.Client();

  @override
  Future<List<Child>?> getListChild(String authToken, int idApoderado) async {

    HttpDioService httpService = HttpDioService();
    httpService.init();
    var pathService = pathServer+stage+childrenService;
    pathService = pathService.replaceAll(":1", idApoderado.toString());
    
    UserRepository repo = UserRepositoryImpl();
    
    try {
      var response = await httpService.request(
        method: Method.GET,
        url: pathService
      );
      if(response.statusCode == 200){

        var apiResultResponse =  ApiResultResponse.fromJson(response.data);
        var dataResponse = childResponseFromJson(json.encode(apiResultResponse.data));
        return getListChildResponseToListChild(dataResponse);

      } else {
        throw ChildrenRepositoryException(message: 'Wrong username or password');
      }
    } catch (e){
      throw ChildrenRepositoryException(message: 'Error en el repository Children');
    }

  }

}

class ChildrenRepositoryException implements Exception {
  final String message;

  ChildrenRepositoryException({this.message = 'Error en el repository Children'});
}