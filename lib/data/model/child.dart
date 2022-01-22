import 'dart:convert';
import 'dart:ffi';

import 'package:clean_app/data/response/child/child_response.dart';

List<dynamic> childSelectedToJson(List<Child> data) => List<dynamic>.from(data.map((x) => x.toJsonIdEstudiante()));

class Child {

  int id;
  String nombres;
  String apPaterno;
  String apMaterno;
  String numDocumento;
  Grado? grado;
  bool isChecked;

  Child({
    this.id = 0,
    this.nombres = "",
    this.apPaterno = "",
    this.apMaterno = "",
    this.numDocumento = "",
    this.grado,
    this.isChecked = false
  });
  
  Map<String, dynamic> toJsonIdEstudiante() => {
    "id_estudiante": id == null ? null : id,
    "check": isChecked
  };

}