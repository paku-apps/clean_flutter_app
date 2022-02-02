import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/qr_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:get/get.dart';

class DetailChargerQRController extends GetxController {

  var usuarioLogged = User().obs;
  var showQR = false.obs;
  var showQRLoading = false.obs;
  var qrDetail = "".obs;

  @override
  void onInit(){
    super.onInit();
    getUserLogged();
    getQRDetail();
  }

  Future<User?> getUserLogged() async {
    UserRepository repo = UserRepositoryImpl();
    var currentUser = await repo.getCurrentUser();
    if(currentUser!=null){
      usuarioLogged.value = currentUser;
    }
    return currentUser;
  }

  Future<String> getQRDetail() async {
    showQRLoading.value = true;
    UserRepository repoUsuario = UserRepositoryImpl();
    var currentUser = await repoUsuario.getCurrentUser();
    QRRepository repo = QRRepositoryImpl();
    var valueQR = await repo.getQRDetail(currentUser!.id);
    if(valueQR!=null){
      qrDetail.value = valueQR;
    }
    showQRLoading.value = false;
    showQR.value = true;
    return qrDetail.value;
  }

}