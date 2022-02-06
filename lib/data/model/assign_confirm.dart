
import 'dart:convert';

List<dynamic> authConfirmationToJson(List<AuthorizationConfirmation> data) => List<dynamic>.from(data.map((x) => x.toJsonAuthConfirm()));

class AuthorizationConfirmation{

  int? id_authorizacion;
  List<int>? inasistencias;

  AuthorizationConfirmation(
    this.id_authorizacion,
    this.inasistencias
  );

  Map<String, dynamic> toJsonAuthConfirm() => {
    "id_autorizacion": id_authorizacion == null ? null : id_authorizacion,
    "inasistencias": inasistencias
  };

}