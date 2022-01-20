import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/repository/child_repository.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:get/get.dart';

class ListAssignController extends GetxController {

  var isLoading = false.obs;
  var listAssign = List<Child>.empty().obs;

  @override
  void onInit(){
    super.onInit();
    mockAuthorization();
    //getChildren();
  }

  void mockAuthorization(){
    //listAssign.value.add(Assign)
  }

  void goToUpdateAssign() {
    Get.toNamed(AppLinks.NEW_ASSIGN);
  }

  Future<bool> deleteAssign() async {
    return true;
  }

   
  Future<List<Child>?> getChildren() async {
    ChildRepository repo = ChildRepositoryImpl();
    var list = await repo.getListChild("auth", 5);
    if(list!=null){
      listAssign.value = list;
    }
    return await repo.getListChild("auth", 5);
  }

}