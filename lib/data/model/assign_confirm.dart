
import 'dart:convert';

List<dynamic> authConfirmationToJson(List<AuthorizationConfirmation> data) => List<dynamic>.from(data.map((x) => x.toJsonAuthConfirm()));

class AuthorizationConfirmation{

  int? id_authorizacion;
  int? id_estudiante;
  bool? check;

  AuthorizationConfirmation(
    this.id_authorizacion,
    this.id_estudiante,
    this.check
  );

  Map<String, dynamic> toJsonAuthConfirm() => {
    "id_autorizacion": id_authorizacion == null ? null : id_authorizacion,
    "id_estudiante": id_estudiante,
    "check": check
  };

}