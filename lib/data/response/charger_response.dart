import 'dart:convert';

List<ChargerResponse> chargerResponseFromJson(String str) => List<ChargerResponse>.from(json.decode(str).map((x) => ChargerResponse.fromJson(x)));

String chargerResponseToJson(List<ChargerResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChargerResponse {
    ChargerResponse({
        this.id,
        this.nombres,
        this.apPaterno,
        this.apMaterno,
        this.numeroDocumento,
        this.correo,
        this.foto,
    });

    int? id;
    String? nombres;
    String? apPaterno;
    String? apMaterno;
    String? numeroDocumento;
    String? correo;
    String? foto;

    factory ChargerResponse.fromJson(Map<String, dynamic> json) => ChargerResponse(
        id: json["id"],
        nombres: json["nombres"],
        apPaterno: json["ap_paterno"],
        apMaterno: json["ap_materno"],
        numeroDocumento: json["numero_documento"],
        correo: json["correo"],
        foto: json["foto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombres": nombres,
        "ap_paterno": apPaterno,
        "ap_materno": apMaterno,
        "numero_documento": numeroDocumento,
        "correo": correo,
        "foto": foto,
    };
}
