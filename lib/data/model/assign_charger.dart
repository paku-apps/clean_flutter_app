class AssignChargerModel{

  AssignChargerModel({
    this.idAutorizado = 0,
    this.nombres = "",
    this.apPaterno = "",
    this.apMaterno = "",
    this.numeroDocumento = "",
    this.correo = "",
    this.foto = "",
    this.estudiantes
  });

    int? idAutorizado;
    String nombres;
    String apPaterno;
    String apMaterno;
    String numeroDocumento;
    String correo;
    String? foto;
    List<AutorizacionEstudianteModel>? estudiantes;

  factory AssignChargerModel.fromJson(Map<String, dynamic> json) => AssignChargerModel(
    idAutorizado: json["id"] == null ? null : json["idAutorizado"],
    nombres: json["nombres"],
    apPaterno: json["apPaterno"],
    apMaterno: json["apMaterno"],
    numeroDocumento: json["numeroDocumento"],
    correo: json["correo"],
    foto: json["foto"],
    estudiantes: json["autorizaciones"] == null ? null : List<AutorizacionEstudianteModel>.from(json["autorizaciones"].map((x) => AutorizacionEstudianteModel.fromJson(x))),
  );

 
  Map<String, dynamic> toJson() {
    return {
      "id": idAutorizado,
      "nombres": nombres,
      "ap_paterno": apPaterno,
      "ap_materno": apMaterno,
      "numeroDocumento": numeroDocumento,
      "correo": correo,
      "foto": foto,
      "autorizaciones": estudiantes == null ? null : List<dynamic>.from(estudiantes!.map((x) => x.toJson()))
    };
  }

}


class AutorizacionEstudianteModel{

  AutorizacionEstudianteModel({
    this.idAutorizacion = 0,
    this.idEstudiante = 0,
    this.nombres = "",
    this.apPaterno = "",
    this.apMaterno = "",
    this.grado = "",
    this.checked = true,
    this.visible = true
  });

    int idAutorizacion;
    int idEstudiante;
    String nombres;
    String apPaterno;
    String apMaterno;
    String grado;
    bool checked;
    bool visible;

    factory AutorizacionEstudianteModel.fromJson(Map<String, dynamic> json) => AutorizacionEstudianteModel(
        idAutorizacion: json["idAutorizacion"],
        idEstudiante: json["idEstudiante"],
        nombres: json["nombres"],
        apPaterno: json["apPaterno"],
        apMaterno: json["apMaterno"],
        grado: json["grado"],
        visible: json["visible"]
    );

    Map<String, dynamic> toJson() => {
        "idAutorizacion": idAutorizacion,
        "idEstudiante": idEstudiante,
        "nombres": nombres,
        "apPaterno": apPaterno,
        "apMaterno": apMaterno,
        "grado": grado,
        "visible": visible
    };

}
