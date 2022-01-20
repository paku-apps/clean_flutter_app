import 'dart:convert';

import 'package:clean_app/data/converters/list_child_model_from_child_response.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/child/child_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:http/http.dart' as http;

abstract class ChildRepository {

  Future<List<Child>?> getListChild(String authToken, int idApoderado);

}

class ChildRepositoryImpl extends ChildRepository {
  static var client = http.Client();

  @override
  Future<List<Child>?> getListChild(String authToken, int idApoderado) async {
    var pathService = pathServer+stage+childrenService;
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
      var dataResponse = childResponseFromJson(json.encode(resultResponse.data));
      return getListChildResponseToListChild(dataResponse);
    } else {
      throw ChildrenRepositoryException(message: 'No se pudo parser Children');
    }

  }

}

class ChildrenRepositoryException implements Exception {
  final String message;

  ChildrenRepositoryException({this.message = 'Error en el repository Children'});
}