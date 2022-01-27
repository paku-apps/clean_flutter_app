    
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
    id: json["id"] == null ? null : json["id"],
    nombres: json["nombres"] == null ? null : json["nombres"],
    apPaterno: json["ap_paterno"] == null ? null : json["ap_paterno"],
    apMaterno: json["ap_materno"] == null ? null : json["ap_materno"],
    numeroDocumento: json["numero_documento"] == null ? null : json["numero_documento"],
    correo: json["correo"] == null ? null : json["correo"],
    foto: json["foto"] == null ? null : json["foto"],
  );


  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "nombres": nombres == null ? null : nombres,
    "ap_paterno": apPaterno == null ? null : apPaterno,
    "ap_materno": apMaterno == null ? null : apMaterno,
    "numero_documento": numeroDocumento == null ? null : numeroDocumento,
    "correo": correo == null ? null : correo,
    "foto": foto == null ? null : foto,
  };

}
    