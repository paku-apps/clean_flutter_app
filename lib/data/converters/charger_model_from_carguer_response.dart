

import 'package:clean_app/data/model/charger.dart';
import 'package:clean_app/data/response/charger_response.dart';

Charger getChargerFromChargerResponse(ChargerResponse chargerResponse){
  
  var charger =  Charger();
  charger.id = chargerResponse.id;
  charger.nombres = chargerResponse.nombres;
  charger.apPaterno = chargerResponse.apPaterno;
  charger.apMaterno = chargerResponse.apMaterno;
  charger.numeroDocumento = chargerResponse.numeroDocumento;
  charger.correo = chargerResponse.correo;
  charger.foto = chargerResponse.foto;

  return charger;
}


List<Charger> getListChargerResponseToListCharger(List<ChargerResponse> list){
  
  List<Charger> listChargers = [];
  list.forEach((chargerData) {
    var charger =  Charger();
    charger.id = chargerData.id;
    charger.nombres = chargerData.nombres;
    charger.apPaterno = chargerData.apPaterno;
    charger.apMaterno = chargerData.apMaterno;
    charger.numeroDocumento = chargerData.numeroDocumento;
    charger.correo = chargerData.correo;
    charger.foto = chargerData.foto;
    listChargers.add(charger);
  });

  return listChargers;
}