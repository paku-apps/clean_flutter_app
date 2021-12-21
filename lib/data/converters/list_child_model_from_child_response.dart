import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/response/child/child_response.dart';

List<Child> getListChildResponseToListChild(List<ChildResponse> list){
  
  List<Child> listChild = [];
  list.forEach((childData) {
    var child =  Child();
    child.id = childData.id;
    child.name = childData.names;
    child.lastname = childData.lastname;
    child.grade = childData.grade;
    child.level = childData.level;
    listChild.add(child);
  });

  return listChild;
}