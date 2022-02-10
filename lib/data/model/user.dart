class User {

  int id;
  String nombres;
  String apellidoPaterno;
  String apellidoMaterno;
  String numerodDocumento;
  String correo;
  String foto;
  bool activo;
  int perfil;
  bool reseteo;

  User({
    this.id = 0,
    this.nombres = "",
    this.apellidoPaterno = "",
    this.apellidoMaterno = "",
    this.numerodDocumento = "",
    this.correo = "",
    this.foto = "",
    this.activo = false,
    this.perfil = 999,
    this.reseteo = false
  });

}