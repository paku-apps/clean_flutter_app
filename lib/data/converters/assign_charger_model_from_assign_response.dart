

import 'package:clean_app/data/model/assign_charger.dart';
import 'package:clean_app/data/response/assignCharger/assign_charger_response.dart';

AssignChargerModel getAssignChargerModelFromAssignCharger(AssignCharger assignCharger){
  var autorizacionModel = AssignChargerModel();
  autorizacionModel.idAutorizado = assignCharger.idAutorizado;
  autorizacionModel.nombres = assignCharger.nombres;
  autorizacionModel.apPaterno = assignCharger.apPaterno;
  autorizacionModel.apMaterno = assignCharger.apMaterno;
  autorizacionModel.numeroDocumento = assignCharger.numeroDocumento;
  autorizacionModel.correo = assignCharger.correo;
  autorizacionModel.foto = assignCharger.foto;
  autorizacionModel.estudiantes = getAutorizacionEstudiantesFromAssignEstudiantes(assignCharger.estudiantes!);
  return autorizacionModel;
}

List<AutorizacionEstudianteModel> getAutorizacionEstudiantesFromAssignEstudiantes(List<EstudianteAutorizacion> listAutorizaciones) {
    List<AutorizacionEstudianteModel> listAssigns = [];
    listAutorizaciones.forEach((assignChargerData) {
    var assignCharger =  AutorizacionEstudianteModel();
    assignCharger.idAutorizacion = assignChargerData.idAutorizacion;
    assignCharger.idEstudiante = assignChargerData.idEstudiante;
    assignCharger.nombres = assignChargerData.nombres;
    assignCharger.apPaterno = assignChargerData.apPaterno;
    assignCharger.apMaterno =assignChargerData.apMaterno;
    assignCharger.grado = assignChargerData.grado;
    listAssigns.add(assignCharger);
  });

  return listAssigns;
}