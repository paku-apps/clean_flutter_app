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
    nombres: json["nombres"] == null ? null : json["nombres"],
    apPaterno: json["apPaterno"] == null ? null : json["apPaterno"],
    apMaterno: json["apMaterno"] == null ? null : json["apMaterno"],
    numeroDocumento: json["numeroDocumento"] == null ? null : json["numeroDocumento"],
    correo: json["correo"] == null ? null : json["correo"],
    foto: json["foto"] == null ? null : json["foto"],
    estudiantes: json["autorizaciones"] == null ? null : List<AutorizacionEstudianteModel>.from(json["autorizaciones"].map((x) => AutorizacionEstudianteModel.fromJson(x))),
  );

 
  Map<String, dynamic> toJson() {
    return {
      "id": idAutorizado,
      "nombres": nombres,
      "ap_paterno": apPaterno,
      "ap_materno": apMaterno,
      "numeroDocumento": numeroDocumento == null ? null : numeroDocumento,
      "correo": correo == null ? null : correo,
      "foto": foto == null ? null : foto,
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
    this.checked = true
  });

    int idAutorizacion;
    int idEstudiante;
    String nombres;
    String apPaterno;
    String apMaterno;
    String grado;
    bool checked;

    factory AutorizacionEstudianteModel.fromJson(Map<String, dynamic> json) => AutorizacionEstudianteModel(
        idAutorizacion: json["idAutorizacion"] == null ? null : json["idAutorizacion"],
        idEstudiante: json["idEstudiante"] == null ? null : json["idEstudiante"],
        nombres: json["nombres"] == null ? null : json["nombres"],
        apPaterno: json["apPaterno"] == null ? null : json["apPaterno"],
        apMaterno: json["apMaterno"] == null ? null : json["apMaterno"],
        grado: json["grado"] == null ? null : json["grado"],
    );

    Map<String, dynamic> toJson() => {
        "idAutorizacion": idAutorizacion == null ? null : idAutorizacion,
        "idEstudiante": idEstudiante == null ? null : idEstudiante,
        "nombres": nombres == null ? null : nombres,
        "apPaterno": apPaterno == null ? null : apPaterno,
        "apMaterno": apMaterno == null ? null : apMaterno,
        "grado": grado == null ? null : grado
    };

}
