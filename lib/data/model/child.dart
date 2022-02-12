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
    "id": id == null ? null : id,
    "check": isChecked
  };

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    id: json["id"] == null ? null : json["id"],
    nombres: json["nombres"] == null ? null : json["nombres"],
    apPaterno: json["ap_paterno"] == null ? null : json["ap_paterno"],
    apMaterno: json["ap_materno"] == null ? null : json["ap_materno"],
    numDocumento: json["numDocumento"] == null ? null : json["numDocumento"],
    grado: json["grado"] == null ? null : Grado.fromJson(json["grado"]),
    isChecked: json["isChecked"] == null ? null : json["isChecked"],
  );

  Map<String, dynamic> toJson() => {
      "id": id == null ? null : id,
      "nombres": nombres == null ? null : nombres,
      "ap_paterno": apPaterno == null ? null : apPaterno,
      "ap_materno": apMaterno == null ? null : apMaterno,
      "numDocumento": numDocumento == null ? null : numDocumento,
      "grado": grado == null ? null : grado!.toJson(),
      "isChecked": isChecked 
  };

}