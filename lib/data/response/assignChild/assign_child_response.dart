// To parse this JSON data, do
//
//     final assignChild = assignChildFromJson(jsonString);

import 'dart:convert';

import 'package:clean_app/data/model/charger.dart';
import 'package:clean_app/data/response/charger_response.dart';
import 'package:clean_app/data/response/child/child_response.dart';

List<AssignChild> assignChildFromJson(String str) => List<AssignChild>.from(json.decode(str).map((x) => AssignChild.fromJson(x)));

String assignChildToJson(List<AssignChild> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssignChild {
    AssignChild({
        this.id = 0,
        this.nombres = "",
        this.apPaterno = "",
        this.apMaterno = "",
        this.grado,
        this.apoderado,
        this.autorizaciones,
    });

    int id;
    String nombres;
    String apPaterno;
    String apMaterno;
    Grado? grado;
    ChargerResponse? apoderado;
    List<Autorizacion>? autorizaciones;

    factory AssignChild.fromJson(Map<String, dynamic> json) => AssignChild(
        id: json["id"] == null ? null : json["id"],
        nombres: json["nombres"] == null ? null : json["nombres"],
        apPaterno: json["ap_paterno"] == null ? null : json["ap_paterno"],
        apMaterno: json["ap_materno"] == null ? null : json["ap_materno"],
        grado: json["grado"] == null ? null : Grado.fromJson(json["grado"]),
        apoderado: json["apoderado"] == null ? null : ChargerResponse.fromJson(json["apoderado"]),
        autorizaciones: json["autorizaciones"] == null ? null : List<Autorizacion>.from(json["autorizaciones"].map((x) => Autorizacion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nombres": nombres == null ? null : nombres,
        "ap_paterno": apPaterno == null ? null : apPaterno,
        "ap_materno": apMaterno == null ? null : apMaterno,
        "grado": grado == null ? null : grado?.toJson(),
        "apoderado": apoderado == null ? null : apoderado?.toJson(),
        "autorizaciones": autorizaciones == null ? null : List<dynamic>.from(autorizaciones!.map((x) => x.toJson())),
    };
}

class Autorizacion {
    Autorizacion({
        this.id = 0,
        this.fechaInicio,
        this.fechaFin,
    });

    int id;
    String? fechaInicio;
    String? fechaFin;

    factory Autorizacion.fromJson(Map<String, dynamic> json) => Autorizacion(
        id: json["id"] == null ? null : json["id"],
        fechaInicio: json["fecha_inicio"] == null ? null : json["fecha_inicio"],
        fechaFin: json["fecha_fin"] == null ? null : json["fecha_fin"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "fecha_inicio": fechaInicio == null ? null : fechaInicio,
        "fecha_fin": fechaFin == null ? null : fechaFin,
    };
}


