import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/repository/child_repository.dart';
import 'package:get/get.dart';

class ListAssignController extends GetxController {

  var isLoading = false;
  var listChildren = List<Child>.empty().obs;

  @override
  void onInit(){
    super.onInit();
    getChildren();
  }

   
  Future<List<Child>?> getChildren() async {
    ChildRepository repo = ChildRepositoryImpl();
    var list = await repo.getListChild();
    if(list!=null){
      listChildren.value = list;
    }
    return await repo.getListChild();
  }

}