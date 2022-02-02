
import 'package:clean_app/data/model/charger.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/response/child/child_response.dart';

class AssignChildModel{

  AssignChildModel({
    this.id = 0,
    this.nombres = "",
    this.apPaterno = "",
    this.apMaterno = "",
    this.grado,
    this.charger,
    this.autorizaciones
  });

    int? id;
    String nombres;
    String apPaterno;
    String apMaterno;
    Grado? grado;
    Charger? charger;
    List<AutorizacionModel>? autorizaciones;

  factory AssignChildModel.fromJson(Map<String, dynamic> json) => AssignChildModel(
    id: json["id"] == null ? null : json["id"],
    nombres: json["nombres"] == null ? null : json["nombres"],
    apPaterno: json["fechaInicio"] == null ? null : json["fechaInicio"],
    apMaterno: json["fechaFin"] == null ? null : json["fechaFin"],
    grado: json["etapa"] == null ? null : Grado.fromJson(json["etapa"]),
    charger: json["charger"] == null ? null : Charger.fromJson(json["charger"]),
    autorizaciones: json["autorizaciones"] == null ? null : List<AutorizacionModel>.from(json["autorizaciones"].map((x) => AutorizacionModel.fromJson(x))),
  );

 
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nombres": nombres,
      "ap_paterno": apPaterno,
      "ap_materno": apMaterno,
      "etapa": grado == null ? null : grado!.toJson(),
      "charger": charger == null ? null : charger!.toJson(),
      "autorizaciones": autorizaciones == null ? null : List<dynamic>.from(autorizaciones!.map((x) => x.toJson()))
    };
  }

}

class AutorizacionModel{

    AutorizacionModel({
    this.id = 0,
    this.fechaInicio,
    this.fechaFin
  });

    int? id;
    String? fechaInicio;
    String? fechaFin;

    factory AutorizacionModel.fromJson(Map<String, dynamic> json) => AutorizacionModel(
        id: json["id"] == null ? null : json["id"],
        fechaInicio: json["fecha_inicio"] == null ? null : json["fecha_inicio"],
        fechaFin: json["fecha_fin"] == null ? null : json["fecha_inicio"]
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "fecha_inicio": fechaInicio == null ? null : fechaInicio,
        "fecha_fin": fechaFin == null ? null : fechaFin,
    };

}