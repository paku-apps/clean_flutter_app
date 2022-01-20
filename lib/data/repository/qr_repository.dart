import 'dart:convert';

import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/data/response/qr_response.dart';
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
    WidgetsFlutterBinding.ensureInitialized();
    var url = Uri.parse(pathServer+stage+qrPrincipalService.replaceAll(":1", idApoderado.toString()));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(keyIdToken);
    var response = await client.post(
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
      var dataResponse = qrPermissionFromJson(json.encode(resultResponse.data));
      prefs.setString(keyQRPrincipal, dataResponse.qrCode);
      prefs.setString(keyQRDate, DateTime.now().add(Duration(hours: 12)).toString());
      return dataResponse.qrCode;
    } else {
      throw QRRepositoryException(message: 'No se pudo parsear QRPermission');
    }
  }

}


class QRRepositoryException implements Exception {
  final String message;

  QRRepositoryException({this.message = 'Error en el repository QR Principal'});
}