import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/response/child/child_response.dart';

List<Child> getListChildResponseToListChild(List<ChildResponse> list){
  
  List<Child> listChild = [];
  for (var childData in list) {
    var child =  Child();
    child.id = childData.id;
    child.nombres = childData.nombres;
    child.apPaterno = childData.apPaterno;
    child.apMaterno = childData.apMaterno;
    child.numDocumento = childData.numeroDocumento ?? "";
    child.isChecked = childData.estado == null ? false : childData.estado!.check;
    child.grado = childData.grado;
    listChild.add(child);
  }

  return listChild;
}