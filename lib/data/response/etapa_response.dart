class EtapaResponse {
    EtapaResponse({
        this.id,
        this.nombre,
    });

    int? id;
    String? nombre;

    factory EtapaResponse.fromJson(Map<String, dynamic> json) => EtapaResponse(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
