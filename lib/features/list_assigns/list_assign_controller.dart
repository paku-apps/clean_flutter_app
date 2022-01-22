import 'package:clean_app/data/model/assign.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/assign_repository.dart';
import 'package:clean_app/data/repository/child_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:get/get.dart';

class ListAssignController extends GetxController {

  var isLoading = false.obs;
  var listAssign = List<Assign>.empty().obs;
  String tokenStored = "";
  var usuarioLogged = User().obs;

  @override
  void onInit(){
    super.onInit();
    getUserLogged();
    getListAssignByUser();
  }

  Future<User?> getUserLogged() async {
    UserRepository repo = UserRepositoryImpl();
    var currentUser = await repo.getCurrentUser();
    if(currentUser!=null){
      usuarioLogged.value = currentUser;
    }
    return currentUser;
  }

  void goToUpdateAssign() {
    Get.toNamed(AppLinks.NEW_ASSIGN);
  }

  Future<bool> deleteAssign() async {
    return true;
  }

  Future<List<Assign>> getListAssignByUser() async {
    UserRepository repoUsuario = UserRepositoryImpl();
    tokenStored = await repoUsuario.getToken();
    AssignRepository repo = AssignRepositoryImpl();
    var idApoderado = usuarioLogged.value.id;
    List<Assign>? list = await repo.getListAssignByApoderado(tokenStored, idApoderado);
    if(list!=null){
      listAssign.value = list;
    }
    return list;
  }
   

}