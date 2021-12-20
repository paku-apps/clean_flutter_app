import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:get/get.dart';

class HomeFatherController extends GetxController {

  var usuarioLogged = User().obs;

  @override
  void onInit(){
    super.onInit();
    getUserLogged();
  }

  Future<User?> getUserLogged() async {
    UserRepository repo = UserRepositoryImpl();
    return await repo.getCurrentUser();
  }

}