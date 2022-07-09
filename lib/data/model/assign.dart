    
import 'package:clean_app/data/model/charger.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/model/etapa.dart';

class Assign{

  Assign({
    this.id = 0,
    this.fechaInicio,
    this.fechaFin,
    this.etapa,
    this.charger,
    this.estudiantes
  });

    int? id;
    String? fechaInicio;
    String? fechaFin;
    Etapa? etapa;
    Charger? charger;
    List<Child>? estudiantes;

  factory Assign.fromJson(Map<String, dynamic> json) => Assign(
    id: json["id"],
    fechaInicio: json["fechaInicio"],
    fechaFin: json["fechaFin"],
    etapa: json["etapa"] == null ? null : Etapa.fromJson(json["etapa"]),
    charger: json["charger"] == null ? null : Charger.fromJson(json["charger"]),
    estudiantes: json["estudiantes"] == null ? null : List<Child>.from(json["estudiantes"].map((x) => Child.fromJson(x))),
  );

 
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fechaInicio": fechaInicio,
      "fechaFin": fechaFin,
      "etapa": etapa == null ? null : etapa!.toJson(),
      "charger": charger == null ? null : charger!.toJson(),
      "estudiantes": estudiantes == null ? null : List<dynamic>.from(estudiantes!.map((x) => x.toJson()))
    };
  }

}