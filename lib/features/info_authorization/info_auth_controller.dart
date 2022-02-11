import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/assign_charger.dart';
import 'package:clean_app/data/model/assign_confirm.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/qr_repository.dart';
import 'package:clean_app/data/repository/supervisor_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/widgets/snackbars/snackbar_get_utils.dart';
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

  @override 
  void onClose(){
    listAuthConfirm.clear();
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
      mainCharger.value.estudiantes?.forEach((student) { 
        listAuthConfirm.add(AuthorizationConfirmation(student.idAutorizacion, student.idEstudiante, true));
      });
    }
    isLoading.value = false;
    return assignCharger;
  }

  void checkChild(int position){
    mainCharger.value.estudiantes![position].checked = !mainCharger.value.estudiantes![position].checked;
    var idAuth = mainCharger.value.estudiantes![position].idAutorizacion;
    var idEstudiante =  mainCharger.value.estudiantes![position].idEstudiante;
    if(mainCharger.value.estudiantes![position].checked == true){
      listAuthConfirm.add(AuthorizationConfirmation(idAuth, idEstudiante, true));
    } else {
      var indexFounded = listAuthConfirm.indexWhere((authValidate) => authValidate.id_estudiante == mainCharger.value.estudiantes![position].idEstudiante);
      if(indexFounded != -1){
        listAuthConfirm.removeAt(indexFounded);
      }
    }
    /*
    if(mainCharger.value.estudiantes![position].checked == false){
      var indexFinded = listAuthConfirm.indexWhere((authValidate) => authValidate.id_authorizacion == idAuth);
      if(indexFinded==-1){
        listAuthConfirm.add(AuthorizationConfirmation(idAuth, [idEstudiante]));
      } else {
        listAuthConfirm[indexFinded].inasistencias!.add(idEstudiante);
      }
    } else {
      var indexFinded = listAuthConfirm.indexWhere((authValidate) => authValidate.id_authorizacion == idAuth);
      if(listAuthConfirm[indexFinded].inasistencias!.length>1){
        listAuthConfirm[indexFinded].inasistencias!.remove(idEstudiante);
      } else {
        listAuthConfirm.removeAt(indexFinded);
      }
    }*/
    update();
  }

  Future<String> registerAuthorization() async {
    if(isNotSelectedChildren()){
      showErrorSnackbar("Tiene que recoger un niñ@", "Por favor seleccione como minimo a un niñ@");
    } else {
      var supervisorRepo = SupervisorRepositoryImpl();
      var state = await supervisorRepo.registerAuthorization(usuarioLogged.value.id, listAuthConfirm);
      if(state=="SUCCESS"){
        Get.offAndToNamed(AppLinks.HOME_SUPERVISOR);
        showSuccessSnackbar("Se registró la autorización", "Se recogieron los niños seleccionados");
      } else {
        showErrorSnackbar("No se pudo registrar la autorización", "Por favor vuelva a intentarlo");
      }
    }
    return "";
  }

  bool isNotSelectedChildren(){
    var listCheckedEstudiantes = mainCharger.value.estudiantes!.where((estudiante) => estudiante.checked == false).toList();
    return listCheckedEstudiantes.length == mainCharger.value.estudiantes!.length;
  }
  
}