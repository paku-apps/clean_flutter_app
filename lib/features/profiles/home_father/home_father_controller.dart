import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/child_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:get/get.dart';

class HomeFatherController extends GetxController {

  var usuarioLogged = User().obs;
  var listChildren = List<Child>.empty().obs;
  //RxList<Child> listChildren = RxList<Child>();

  @override
  void onInit(){
    super.onInit();
    getUserLogged();
    getChildren();
  }

  Future<User?> getUserLogged() async {
    UserRepository repo = UserRepositoryImpl();
    return await repo.getCurrentUser();
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