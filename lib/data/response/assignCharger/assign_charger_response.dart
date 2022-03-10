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
        idAutorizado: json["id_autorizado"] == null ? null : json["id_autorizado"],
        nombres: json["nombres"] == null ? null : json["nombres"],
        apPaterno: json["ap_paterno"] == null ? null : json["ap_paterno"],
        apMaterno: json["ap_materno"] == null ? null : json["ap_materno"],
        numeroDocumento: json["numero_documento"] == null ? null : json["numero_documento"],
        correo: json["correo"] == null ? null : json["correo"],
        foto: json["foto"] == "" ? null : json["foto"],
        estudiantes: json["estudiantes"] == null ? null : List<EstudianteAutorizacion>.from(json["estudiantes"].map((x) => EstudianteAutorizacion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_autorizado": idAutorizado == null ? null : idAutorizado,
        "nombres": nombres == null ? null : nombres,
        "ap_paterno": apPaterno == null ? null : apPaterno,
        "ap_materno": apMaterno == null ? null : apMaterno,
        "numero_documento": numeroDocumento == null ? null : numeroDocumento,
        "correo": correo == null ? null : correo,
        "foto": foto == null ? null : foto,
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
    });

    int idAutorizacion;
    int idEstudiante;
    String nombres;
    String apPaterno;
    String apMaterno;
    String grado;

    factory EstudianteAutorizacion.fromJson(Map<String, dynamic> json) => EstudianteAutorizacion(
        idAutorizacion: json["id_autorizacion"] == null ? null : json["id_autorizacion"],
        idEstudiante: json["id_estudiante"] == null ? null : json["id_estudiante"],
        nombres: json["nombres"] == null ? null : json["nombres"],
        apPaterno: json["ap_paterno"] == null ? null : json["ap_paterno"],
        apMaterno: json["ap_materno"] == null ? null : json["ap_materno"],
        grado: json["grado"] == null ? null : json["grado"],
    );

    Map<String, dynamic> toJson() => {
        "id_autorizacion": idAutorizacion == null ? null : idAutorizacion,
        "id_estudiante": idEstudiante == null ? null : idEstudiante,
        "nombres": nombres == null ? null : nombres,
        "ap_paterno": apPaterno == null ? null : apPaterno,
        "ap_materno": apMaterno == null ? null : apMaterno,
        "grado": grado == null ? null : grado,
    };
}
