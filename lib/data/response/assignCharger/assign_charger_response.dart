// To parse this JSON data, do
//
//     final assignCharger = assignChargerFromJson(jsonString);

import 'dart:convert';

AssignCharger assignChargerFromJson(String str) => AssignCharger.fromJson(json.decode(str));

String assignChargerToJson(AssignCharger data) => json.encode(data.toJson());

class AssignCharger {
    AssignCharger({
        this.idAutorizado = 0,
        this.nombres = "",
        this.apPaterno = "",
        this.apMaterno = "",
        this.numeroDocumento = "",
        this.correo = "",
        this.foto = "",
        this.estudiantes,
    });

    int idAutorizado;
    String nombres;
    String apPaterno;
    String apMaterno;
    String numeroDocumento;
    String correo;
    String? foto;
    List<EstudianteAutorizacion>? estudiantes;

    factory AssignCharger.fromJson(Map<String, dynamic> json) => AssignCharger(
        idAutorizado: json["id_autorizado"],
        nombres: json["nombres"],
        apPaterno: json["ap_paterno"],
        apMaterno: json["ap_materno"],
        numeroDocumento: json["numero_documento"],
        correo: json["correo"],
        foto: json["foto"] == "" ? null : json["foto"],
        estudiantes: json["estudiantes"] == null ? null : List<EstudianteAutorizacion>.from(json["estudiantes"].map((x) => EstudianteAutorizacion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_autorizado": idAutorizado,
        "nombres": nombres,
        "ap_paterno": apPaterno,
        "ap_materno": apMaterno,
        "numero_documento": numeroDocumento,
        "correo": correo,
        "foto": foto,
        "estudiantes": estudiantes == null ? null : List<dynamic>.from(estudiantes!.map((x) => x.toJson())),
    };
}

class EstudianteAutorizacion {
    EstudianteAutorizacion({
        this.idAutorizacion = 0,
        this.idEstudiante = 0,
        this.nombres = "",
        this.apPaterno = "",
        this.apMaterno = "",
        this.grado = "",
        this.visible = true,
    });

    int idAutorizacion;
    int idEstudiante;
    String nombres;
    String apPaterno;
    String apMaterno;
    String grado;
    bool visible;

    factory EstudianteAutorizacion.fromJson(Map<String, dynamic> json) => EstudianteAutorizacion(
        idAutorizacion: json["id_autorizacion"],
        idEstudiante: json["id_estudiante"],
        nombres: json["nombres"],
        apPaterno: json["ap_paterno"],
        apMaterno: json["ap_materno"],
        grado: json["grado"],
        visible: json["id_estudiante"] == 1003,
    );

    Map<String, dynamic> toJson() => {
        "id_autorizacion": idAutorizacion,
        "id_estudiante": idEstudiante,
        "nombres": nombres,
        "ap_paterno": apPaterno,
        "ap_materno": apMaterno,
        "grado": grado,
        "visible": visible
    };
}
