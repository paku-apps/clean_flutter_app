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
  Future<void> clearQR();

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
        prefs.setString(keyQRDate, DateTime.now().add(const Duration(hours: 12)).toString());
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
    
    /*
        var alumno1 = AutorizacionEstudianteModel();
        alumno1.idAutorizacion = 1515;
        alumno1.idEstudiante = 3001;
        alumno1.nombres = "Alumno01";
        alumno1.apPaterno = "Paterno01";
        alumno1.apMaterno = "Materno01";
        alumno1.grado = "5to";
        alumno1.checked = true;

        var alumno2 = AutorizacionEstudianteModel();
        alumno2.idAutorizacion = 1515;
        alumno2.idEstudiante = 3002;
        alumno2.nombres = "Alumno02";
        alumno2.apPaterno = "Paterno02";
        alumno2.apMaterno = "Materno02";
        alumno2.grado = "5to";
        alumno2.checked = true;
        
        var alumno3 = AutorizacionEstudianteModel();
        alumno3.idAutorizacion = 1515;
        alumno3.idEstudiante = 3003;
        alumno3.nombres = "Alumno03";
        alumno3.apPaterno = "Paterno03";
        alumno3.apMaterno = "Materno03";
        alumno3.grado = "5to";
        alumno3.checked = true;
        var demo = AssignChargerModel();
        demo.idAutorizado = 2323;
        demo.apPaterno = "AMAO";
        demo.apMaterno = "QUIJANDRIA";
        demo.numeroDocumento = "555555";
        demo.correo = "ulises@gmail.com";
        demo.foto = "";
        demo.estudiantes = [alumno1, alumno2, alumno3];
        return demo;
        */
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
        if(apiResultResponse.data != ""){    
          var dataResponse = assignChargerFromJson(json.encode(apiResultResponse.data));
          var assignCharger = getAssignChargerModelFromAssignCharger(dataResponse);
          return assignCharger;
        } else {
          return AssignChargerModel(idAutorizado: 999999);
        }
      } else if(response.statusCode == 500){
        return AssignChargerModel();
      } else {
        throw QRRepositoryException(message: 'Error en el repository QR Detail');
      }
    } catch (e){
      throw QRRepositoryException(message: 'Error en el repository QR Detail');
    }
  }

  @override
  Future<void> clearQR() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyQRPrincipal);
    await prefs.remove(keyIdToken);
    await prefs.remove(keyQRDate);
  }
}


class QRRepositoryException implements Exception {
  final String message;

  QRRepositoryException({this.message = 'Error en el repository QR Principal'});
}