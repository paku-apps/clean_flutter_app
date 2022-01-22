

import 'package:clean_app/data/model/etapa.dart';
import 'package:clean_app/data/response/etapa_response.dart';

Etapa getEtapaFromEtapaResponse(EtapaResponse etapaResponse){
  
  var etapa =  Etapa();
  etapa.id = etapaResponse.id;
  etapa.nombre = etapaResponse.nombre;

  return etapa;
}