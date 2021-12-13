import 'package:clean_app/data/model/user.dart';

abstract class UserRepository {

  bool isUserLogged();
  User getCurrentUser();
  void saveUser();

}

class UserRepositoryImpl extends UserRepository {
  @override
  User getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  bool isUserLogged() {
    // TODO: implement isUserLogged
    throw UnimplementedError();
  }

  @override
  void saveUser() {
    // TODO: implement saveUser
  }
}