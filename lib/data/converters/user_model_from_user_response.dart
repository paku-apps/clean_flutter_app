import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/response/auth/user_response.dart';

User getUserFromUserBD(UserBd user){
  var usuario =  User();
  usuario.id = user.id;
  usuario.nombres = user.nombres;
  usuario.apellidoPaterno = user.apellidoPaterno;
  usuario.apellidoMaterno = user.apellidoMaterno;
  usuario.numerodDocumento = user.numDocumento;
  usuario.correo = user.correo;
  usuario.foto = user.foto;
  usuario.activo = user.activo;
  usuario.perfil = user.perfil;

  return usuario;
}