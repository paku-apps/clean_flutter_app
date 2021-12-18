class UserBd {
    UserBd({
        this.idUsuario = 0,
        this.nombre = "",
        this.apellido = "",
        this.correo = ""
    });

    int idUsuario;
    String nombre;
    String apellido;
    String correo;

    factory UserBd.fromJson(Map<String, dynamic> json) => UserBd(
        idUsuario: json["id_usuario"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correo: json["correo"],
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "nombre": nombre,
        "apellido": apellido,
        "correo": correo,
    };
}
