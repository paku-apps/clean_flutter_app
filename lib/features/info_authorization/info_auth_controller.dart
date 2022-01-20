

import 'package:clean_app/data/model/child.dart';
import 'package:get/get.dart';

class InfoAuthorizationController extends GetxController {

  var listChildren = List<Child>.empty().obs;

  @override
  void onInit(){
    super.onInit();
    mockListChildren();
  }

  void mockListChildren() {
    //listChildren.value.add(Child(id: "15", name: "Takeshi", lastname: "Farro", grade:  "2",level:  "Primaria"));
    //listChildren.value.add(Child(id: "16", name: "Cesar", lastname: "Chavez", grade:  "4",level:  "Primaria"));
    //listChildren.value.add(Child(id: "17", name: "Kenyi", lastname: "Mendoza", grade:  "1",level:  "Secundaria"));
    //listChildren.value.add(Child(id: "18", name: "Anderson", lastname: "Estela", grade:  "5",level:  "Secundaria"));
  }

  void checkChild(int position){
    listChildren.value[position].isChecked = !listChildren.value[position].isChecked;
    update();
  }

  
}