import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/response/auth/user_response.dart';

User getUserFromUserResponse(UserBd user){
  var usuario =  User();
  usuario.name = user.nombre;
  usuario.lastName = user.apellido;
  usuario.email = user.correo;

  return usuario;
}