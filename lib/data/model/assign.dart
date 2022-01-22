    
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

}