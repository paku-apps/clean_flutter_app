import 'package:clean_app/data/converters/charger_model_from_carguer_response.dart';
import 'package:clean_app/data/model/assign_child.dart';
import 'package:clean_app/data/response/assignChild/assign_child_response.dart';



AutorizacionModel getAutorizacionModelFromAutorizacionResponse(Autorizacion autorizacion){
  var autorizacionModel = AutorizacionModel();
  autorizacionModel.id = autorizacion.id;
  autorizacionModel.fechaInicio = autorizacion.fechaInicio;
  autorizacionModel.fechaFin = autorizacion.fechaFin;
  return autorizacionModel;
}

List<AutorizacionModel> getListAutorizacionModelFromListAutorizacionResponse(List<Autorizacion> list){

  List<AutorizacionModel> listautorizaciones = [];
  list.forEach((authorizacionData) {
    var autorizacionModel =  AutorizacionModel();
    autorizacionModel.id = authorizacionData.id;
    autorizacionModel.fechaInicio = authorizacionData.fechaInicio;
    autorizacionModel.fechaFin = authorizacionData.fechaFin;
    listautorizaciones.add(autorizacionModel);
  });
  return listautorizaciones;
}

List<AssignChildModel> getListAssignChildResponseToListAssignChild(List<AssignChild> list){
  
  List<AssignChildModel> listAssigns = [];
  list.forEach((assignChildData) {
    var assignChild =  AssignChildModel();
    assignChild.id = assignChildData.id;
    assignChild.nombres = assignChildData.nombres;
    assignChild.apPaterno = assignChildData.apPaterno;
    assignChild.apMaterno =assignChildData.apMaterno;
    assignChild.grado = assignChildData.grado;
    assignChild.charger = getChargerFromChargerResponse(assignChildData.apoderado!);
    assignChild.autorizaciones = getListAutorizacionModelFromListAutorizacionResponse(assignChildData.autorizaciones!);
    listAssigns.add(assignChild);
  });

  return listAssigns;
}