import 'dart:convert';
import 'package:clean_app/data/response/charger_response.dart';
import 'package:clean_app/data/response/child/child_response.dart';
import 'package:clean_app/data/response/etapa_response.dart';

class AssignResponse {
    AssignResponse({
        this.id,
        this.fechaInicio,
        this.fechaFin,
        this.etapa,
        this.autorizado,
        this.estudiantes
    });

    int? id;
    DateTime? fechaInicio;
    DateTime? fechaFin;
    EtapaResponse? etapa;
    ChargerResponse? autorizado;
    List<ChildResponse>? estudiantes;

    factory AssignResponse.fromJson(Map<String, dynamic> json) => AssignResponse(
        id: json["id"] == null ? null : json["id"],
        fechaInicio: json["fecha_inicio"] == null ? null : DateTime.parse(json["fecha_inicio"]),
        fechaFin: json["fecha_fin"] == null ? null : DateTime.parse(json["fecha_fin"]),
        etapa: json["etapa"] == null ? null : EtapaResponse.fromJson(json["etapa"]),
        autorizado: json["autorizado"] == null ? null : ChargerResponse.fromJson(json["autorizado"]),
        estudiantes: json["estudiantes"] == null ? null : List<ChildResponse>.from(json["estudiantes"].map((x) => ChildResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "fecha_inicio": fechaInicio == null ? null : "${fechaInicio?.year.toString().padLeft(4, '0')}-${fechaInicio?.month.toString().padLeft(2, '0')}-${fechaInicio?.day.toString().padLeft(2, '0')}",
        "fecha_fin": fechaFin == null ? null : "${fechaFin?.year.toString().padLeft(4, '0')}-${fechaFin?.month.toString().padLeft(2, '0')}-${fechaFin?.day.toString().padLeft(2, '0')}",
        "etapa": etapa == null ? null : etapa?.toJson(),
        "autorizado": autorizado == null ? null : autorizado?.toJson(),
        "estudiantes": estudiantes == null ? null : List<dynamic>.from(estudiantes!.map((x) => x.toJson())),
    };
}