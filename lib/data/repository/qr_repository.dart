import 'dart:convert';

import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/data/response/qr_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class QRRepository {

  Future<String?> getQRPrincipal();

}

class QRRepositoryImpl extends QRRepository {

  final keyQRPrincipal = "SP_KEY_QR_PRINCIPAL";
  final keyQRDate = "SP_KEY_QR_DATE";
  static var client = http.Client();

  @override
  Future<String?> getQRPrincipal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stringDate = prefs.getString(keyQRDate);
    if(stringDate!=null){
      var dateConsult = DateTime.parse(stringDate).toUtc();
      if(dateConsult.compareTo(DateTime.now())<0){
        return prefs.getString(keyQRPrincipal);
      } else {
        return await getRemoteQRPrincipal();
      }
    } else {
       return await getRemoteQRPrincipal();
    }

  }

  Future<String?> getRemoteQRPrincipal() async {
    var url = Uri.parse(pathServer+stage+qrPrincipalService);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await client.get(
      url, 
      headers: {"Content-Type": "application/json"}
    );
    if(response.statusCode == 200){
      var jsonResponse = response.body;
      var resultResponse = apiResultResponseFromJson(jsonResponse);
      var dataResponse = qrPermissionFromJson(json.encode(resultResponse.data));
      prefs.setString(keyQRPrincipal, dataResponse.qrCode);
      prefs.setString(keyQRDate, DateTime.now().toString());
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