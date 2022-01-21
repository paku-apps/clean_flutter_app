class EtapaResponse {
    EtapaResponse({
        this.id,
        this.nombre,
    });

    int? id;
    String? nombre;

    factory EtapaResponse.fromJson(Map<String, dynamic> json) => EtapaResponse(
        id: json["id"] == null ? null : json["id"],
        nombre: json["nombre"] == null ? null : json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nombre": nombre == null ? null : nombre,
    };
}
