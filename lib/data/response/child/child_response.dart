import 'dart:convert';

List<ChildResponse> childResponseFromJson(String str) => List<ChildResponse>.from(json.decode(str).map((x) => ChildResponse.fromJson(x)));

String childResponseToJson(List<ChildResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChildResponse {
    ChildResponse({
      this.id = 0,
      this.nombres = "",
      this.apPaterno = "",
      this.apMaterno = "",
      this.numeroDocumento = "",
      this.grado,
      this.estado
    });

    int id;
    String nombres;
    String apPaterno;
    String apMaterno;
    String? numeroDocumento;
    Grado? grado;
    EstadoEstudiante? estado;

    factory ChildResponse.fromJson(Map<String, dynamic> json) => ChildResponse(
        id: json["id"],
        nombres: json["nombres"],
        apPaterno: json["ap_paterno"],
        apMaterno: json["ap_materno"],
        numeroDocumento: json["numero_documento"],
        grado: json["grado"] == null ? null : Grado.fromJson(json["grado"]),
        estado: json["estado"] == null ? null : EstadoEstudiante.fromJson(json["estado"])
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombres": nombres,
        "ap_paterno": apPaterno,
        "ap_materno": apMaterno,
        "numero_documento": numeroDocumento,
        "grado": grado == null ? null : grado?.toJson(),
        "estado": estado == null ? null : estado?.toJson()
    };
}

class Grado {
    Grado({
        this.id = 0,
        this.nombre = "",
    });

    int id;
    String nombre;

    factory Grado.fromJson(Map<String, dynamic> json) => Grado(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}

class EstadoEstudiante {
  EstadoEstudiante({
    this.check = false
  });

  bool check;

  factory EstadoEstudiante.fromJson(Map<String, dynamic> json) => EstadoEstudiante(
    check: json["check"]
  );

  Map<String, dynamic> toJson() => {
    "check": check
  };
}
