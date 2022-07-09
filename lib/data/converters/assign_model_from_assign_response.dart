
import 'package:clean_app/data/converters/charger_model_from_carguer_response.dart';
import 'package:clean_app/data/converters/etapa_model_from_etapa_response.dart';
import 'package:clean_app/data/converters/list_child_model_from_child_response.dart';
import 'package:clean_app/data/model/assign.dart';
import 'package:clean_app/data/response/assign_response.dart';
import 'package:clean_app/utils/function_utils.dart';

Assign getAssignFromAssignResponse(AssignResponse assignResponse){
  
  var assign =  Assign();
  assign.id = assignResponse.id;
  assign.fechaInicio = transformDateTimeToFormat(assignResponse.fechaInicio!);
  assign.fechaFin = transformDateTimeToFormat(assignResponse.fechaFin!);
  assign.etapa = getEtapaFromEtapaResponse(assignResponse.etapa!);
  assign.charger = getChargerFromChargerResponse(assignResponse.autorizado!);
  assign.estudiantes = getListChildResponseToListChild(assignResponse.estudiantes!);
  return assign;
}


List<Assign> getListAssignResponseToListAssign(List<AssignResponse> list){
  
  List<Assign> listAssigns = [];
  for (var assignData in list) {
    var charger =  Assign();
    charger.id = assignData.id;
    charger.fechaInicio = transformDateTimeToFormat(assignData.fechaInicio!);
    charger.fechaFin = transformDateTimeToFormat(assignData.fechaFin!);
    charger.etapa = getEtapaFromEtapaResponse(assignData.etapa!);
    charger.charger = getChargerFromChargerResponse(assignData.autorizado!);
    charger.estudiantes = getListChildResponseToListChild(assignData.estudiantes!);
    listAssigns.add(charger);
  }

  return listAssigns;
}