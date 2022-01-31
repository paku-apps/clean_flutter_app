import 'dart:convert';

import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/child_repository.dart';
import 'package:clean_app/data/repository/qr_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:get/get.dart';

class HomeFatherController extends GetxController {
  
  final AuthenticationController _authenticationController = Get.find();

  var usuarioLogged = User().obs;
  var listChildren = List<Child>.empty().obs;
  String tokenStored = "";
  var showQRLoading = false.obs;
  var showQR = false.obs;
  var qrPrincipal = "".obs;
  var currentPage = "HOMEPAGE".obs;

  @override
  void onInit(){
    super.onInit();
    getUserLogged();
    getChildren();
  }

  Future<User?> getUserLogged() async {
    UserRepository repo = UserRepositoryImpl();
    var currentUser = await repo.getCurrentUser();
    if(currentUser!=null){
      usuarioLogged.value = currentUser;
    }
    return currentUser;
  }
  
  Future<List<Child>?> getChildren() async {
    UserRepository repoUsuario = UserRepositoryImpl();
    tokenStored = await repoUsuario.getToken();
    ChildRepository repo = ChildRepositoryImpl();
    var idApoderado = usuarioLogged.value.id;
    List<Child>? list = await repo.getListChild(tokenStored, idApoderado);
    if(list!=null){
      listChildren.value = list;
    }
    return list;
  }

  Future<String?> getQRPrincipal() async {
    showQRLoading.value = true;
    QRRepository qrRespository = QRRepositoryImpl();
    var idApoderado = usuarioLogged.value.id;
    var qr = await qrRespository.getQRPrincipal(idApoderado);
    showQR.value = true;
    showQRLoading.value = false;
    if(qr!=null){
      qrPrincipal.value = qr;
    }
    return qr;
  }

  Future<void> closeSession() async {
    _authenticationController.signOut();
    UserRepository repoUsuario = UserRepositoryImpl();
    await repoUsuario.clearDataUser();
  }
}