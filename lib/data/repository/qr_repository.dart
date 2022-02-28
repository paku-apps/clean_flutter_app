import 'dart:convert';

import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/converters/assign_charger_model_from_assign_response.dart';
import 'package:clean_app/data/model/assign_charger.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/assignCharger/assign_charger_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/data/response/qr_response.dart';
import 'package:clean_app/services/dio_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class QRRepository {

  Future<String?> getQRPrincipal(int idApoderado);
  Future<String?> getQRDetail(int idApoderado);
  Future<AssignChargerModel> getInfoFromQR(String iv, String codigo);

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
    HttpDioService httpService = HttpDioService();
    httpService.init();
    UserRepository repo = UserRepositoryImpl();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var pathService = pathServer+stage+qrPrincipalService;
    pathService = pathService.replaceAll(":1", idApoderado.toString());
    
    
    try {
      var response = await httpService.request(
        method: Method.POST,
        url: pathService
      );
      if(response.statusCode == 200){

        var apiResultResponse =  ApiResultResponse.fromJson(response.data);
        var dataResponse = qrPermissionFromJson(json.encode(apiResultResponse.data));
        prefs.setString(keyQRPrincipal, dataResponse.iv+ separatorQR + dataResponse.qrCode); 
        prefs.setString(keyQRDate, DateTime.now().add(Duration(hours: 12)).toString());
        return dataResponse.iv+ separatorQR + dataResponse.qrCode;

      } else {
        throw QRRepositoryException(message: 'Wrong username or password');
      }
    } catch (e){
      throw QRRepositoryException(message: 'Error en el repository QR Principal');
    }
  }

  @override
  Future<String?> getQRDetail(int idApoderado) async {
    HttpDioService httpService = HttpDioService();
    httpService.init();

    var pathService = pathServer+stage+generateQRDetail;
    pathService = pathService.replaceAll(":1", idApoderado.toString());
    
    
    try {
      var response = await httpService.request(
        method: Method.POST,
        url: pathService
      );
      if(response.statusCode == 200){

        var apiResultResponse =  ApiResultResponse.fromJson(response.data);
        var dataResponse = qrPermissionFromJson(json.encode(apiResultResponse.data));
        return dataResponse.iv+ separatorQR + dataResponse.qrCode;

      } else {
        throw QRRepositoryException(message: 'Error en el repository QR Detail');
      }
    } catch (e){
      throw QRRepositoryException(message: 'Error en el repository QR Detail');
    }
  }

  @override
  Future<AssignChargerModel> getInfoFromQR(String iv, String codigoQr) async {
    HttpDioService httpService = HttpDioService();
    httpService.init();

    var pathService = pathServer+stage+pathDecodeQR;    
    
    try {
      var response = await httpService.request(
        method: Method.POST,
        url: pathService,
        params: {
          "iv": iv,
          "codigoqr": codigoQr
        }
      );
      if(response.statusCode == 200){

        var apiResultResponse =  ApiResultResponse.fromJson(response.data);
        var dataResponse = assignChargerFromJson(json.encode(apiResultResponse.data));
        var assignCharger = getAssignChargerModelFromAssignCharger(dataResponse);
        return assignCharger;

      } else if(response.statusCode == 500){
        return AssignChargerModel();
      } else {
        throw QRRepositoryException(message: 'Error en el repository QR Detail');
      }
    } catch (e){
      throw QRRepositoryException(message: 'Error en el repository QR Detail');
    }
  }
}


class QRRepositoryException implements Exception {
  final String message;

  QRRepositoryException({this.message = 'Error en el repository QR Principal'});
}