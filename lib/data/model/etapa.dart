class Etapa {

  Etapa({
    this.id = 0,
    this.nombre,
  });

    int? id;
    String? nombre;

  Etapa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() => {
      "id": id == null ? null : id,
      "nombre": nombre == null ? null : nombre,
  };

}