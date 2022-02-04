

import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/assign_charger.dart';
import 'package:clean_app/data/model/assign_confirm.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/qr_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:get/get.dart';

class InfoAuthorizationController extends GetxController {

  var listChildren = List<Child>.empty().obs;
  var usuarioLogged = User().obs;
  var qrToDecoded = "".obs;
  var mainCharger = AssignChargerModel().obs;
  var isLoading = true.obs;
  var listAuthConfirm = List<AuthorizationConfirmation>.empty().obs;

  @override
  void onInit(){
    super.onInit();
    getUserLogged();
  }

  Future<User?> getUserLogged() async {
    UserRepository repo = UserRepositoryImpl();
    var currentUser = await repo.getCurrentUser();
    if(currentUser!=null){
      usuarioLogged.value = currentUser;
    }
    return currentUser;
  }

  Future<AssignChargerModel?> getDetailFromQR() async {
    isLoading.value = true;
    var partsQr = qrToDecoded.value.split(separatorQR);
    var iv = partsQr[0];
    var codigoqr = partsQr[1];
    QRRepository qrRepository = QRRepositoryImpl();
    var assignCharger = await qrRepository.getInfoFromQR(iv, codigoqr);
    if(assignCharger != null){
      mainCharger.value =assignCharger;
    }
    isLoading.value = false;
    return assignCharger;
  }

  void checkChild(int position){
    mainCharger.value.estudiantes![position].checked = !mainCharger.value.estudiantes![position].checked;
    if(mainCharger.value.estudiantes![position].checked == false){

    }
    update();
  }
  
}