    
class Charger{

  Charger({
    this.id = 0,
    this.nombres,
    this.apPaterno,
    this.apMaterno,
    this.numeroDocumento,
    this.correo,
    this.foto
  });

    int? id;
    String? nombres;
    String? apPaterno;
    String? apMaterno;
    String? numeroDocumento;
    String? correo;
    String? foto;

  factory Charger.fromJson(Map<String, dynamic> json) => Charger(
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
    