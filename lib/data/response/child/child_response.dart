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
      this.grado
    });

    int id;
    String nombres;
    String apPaterno;
    String apMaterno;
    String? numeroDocumento;
    Grado? grado;

    factory ChildResponse.fromJson(Map<String, dynamic> json) => ChildResponse(
        id: json["id"] == null ? null : json["id"],
        nombres: json["nombres"] == null ? null : json["nombres"],
        apPaterno: json["ap_paterno"] == null ? null : json["ap_paterno"],
        apMaterno: json["ap_materno"] == null ? null : json["ap_materno"],
        numeroDocumento: json["numero_documento"] == null ? null : json["numero_documento"],
        grado: json["grado"] == null ? null : Grado.fromJson(json["grado"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nombres": nombres == null ? null : nombres,
        "ap_paterno": apPaterno == null ? null : apPaterno,
        "ap_materno": apMaterno == null ? null : apMaterno,
        "numero_documento": numeroDocumento == null ? null : numeroDocumento,
        "grado": grado == null ? null : grado?.toJson(),
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
