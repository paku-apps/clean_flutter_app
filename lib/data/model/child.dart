import 'dart:ffi';

import 'package:clean_app/data/response/child/child_response.dart';

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

}