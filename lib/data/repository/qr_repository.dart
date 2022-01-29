import 'dart:convert';

import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/data/response/qr_response.dart';
import 'package:clean_app/services/dio_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class QRRepository {

  Future<String?> getQRPrincipal(int idApoderado);

}

class QRRepositoryImpl extends QRRepository {

  final keyQRPrincipal = "SP_KEY_QR_PRINCIPAL";
  final keyQRDate = "SP_KEY_QR_DATE";
  final keyIdToken = "SP_KEY_APP_TOKEN";
  static var client = http.Client();

  @override
  Future<String?> getQRPrincipal(int idApoderado) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stringDate = prefs.getString(keyQRDate);
    if(stringDate!=null){
      var dateConsult = DateTime.parse(stringDate).toUtc();
      if(dateConsult.compareTo(DateTime.now())>0){
        return prefs.getString(keyQRPrincipal);
      } else {
        return await getRemoteQRPrincipal(idApoderado);
      }
    } else {
       return await getRemoteQRPrincipal(idApoderado);
    }

  }

  Future<String?> getRemoteQRPrincipal(int idApoderado) async {

    HttpDioService httpService = HttpDioService();
    httpService.init();
    UserRepository repo = UserRepositoryImpl();

    var pathService = pathServer+stage+qrPrincipalService.replaceAll(":1", idApoderado.toString());
    pathService = pathService.replaceAll(":1", idApoderado.toString());
    
    
    try {
      var response = await httpService.request(
        method: Method.POST,
        url: pathService
      );
      if(response.statusCode == 200){

        var apiResultResponse =  ApiResultResponse.fromJson(response.data);
        var dataResponse = qrPermissionFromJson(json.encode(apiResultResponse.data));
        return dataResponse.qrCode;

      } else {
        throw QRRepositoryException(message: 'Wrong username or password');
      }
    } catch (e){
      throw QRRepositoryException(message: 'Error en el repository QR Principal');
    }
  }

}


class QRRepositoryException implements Exception {
  final String message;

  QRRepositoryException({this.message = 'Error en el repository QR Principal'});
}