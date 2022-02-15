class UserBd {
  
    int id;
    String nombres;
    String apellidoPaterno;
    String apellidoMaterno;
    String numDocumento;
    String correo;
    String? foto;
    String fechaRegistro;
    String fechaUpdate;
    bool activo;
    int perfil;
    bool reseteo;

    UserBd({
        this.id = 0,
        this.nombres = "",
        this.apellidoPaterno = "",
        this.apellidoMaterno = "",
        this.numDocumento = "",
        this.correo = "",
        this.foto = "",
        this.fechaRegistro = "",
        this.fechaUpdate = "",
        this.activo = false,
        this.perfil = 999,
        this.reseteo = false
    });

    factory UserBd.fromJson(Map<String, dynamic> json) => UserBd(
        id: json["id"],
        nombres: json["nombres"],
        apellidoPaterno: json["ap_paterno"],
        apellidoMaterno: json["ap_materno"],
        numDocumento: json["numero_documento"],
        correo: json["correo"],
        foto: json["foto"] ?? null,
        fechaRegistro: json["fecha_registro"],
        fechaUpdate: json["fecha_update"],
        activo: json["activo"],
        perfil: json["id_perfil"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombres": nombres,
        "ap_paterno": apellidoPaterno,
        "ap_materno": apellidoMaterno,
        "numero_documento": numDocumento,
        "correo": correo,
        "foto": foto,
        "fecha_registro": fechaRegistro,
        "fecha_update": fechaUpdate,
        "activo": activo,
        "id_perfil": perfil
    };
}
