import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/assign_charger.dart';
import 'package:clean_app/data/model/assign_confirm.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/qr_repository.dart';
import 'package:clean_app/data/repository/supervisor_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/widgets/snackbars/snackbar_get_utils.dart';
import 'package:get/get.dart';

class InfoAuthorizationController extends GetxController {

  var listChildren = List<Child>.empty().obs;
  var usuarioLogged = User().obs;
  var qrToDecoded = "".obs;
  var mainCharger = AssignChargerModel().obs;
  var isLoading = true.obs;
  var isLoadingRegister = false.obs;
  var isCheckForAll = false.obs;
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
    try {
      var assignCharger = await qrRepository.getInfoFromQR(iv, codigoqr);
      if(assignCharger.idAutorizado != null){
        mainCharger.value =assignCharger;
        mainCharger.value.estudiantes?.forEach((student) { 
          listAuthConfirm.add(AuthorizationConfirmation(student.idAutorizacion, student.idEstudiante, true));
          validateCheckForAll();
        });
        isLoading.value = false;
        return assignCharger;
      }
      if(assignCharger.idAutorizado == 999999) {
        isLoading.value = false;
        return assignCharger;
      }
    } catch(e) {
      isLoading.value = false;
      return null;
    }
    return null;
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
    validateCheckForAll();
    update();
  }

  Future<String> registerAuthorization() async {
    isLoadingRegister.value = true;
    if(isNotSelectedChildren()){
      showErrorSnackbar("Tiene que recoger un niñ@", "Por favor seleccione como minimo a un niñ@");
    } else {
      var supervisorRepo = SupervisorRepositoryImpl();
      var state = await supervisorRepo.registerAuthorization(usuarioLogged.value.id, listAuthConfirm);
      if(state=="SUCCESS"){
        isLoadingRegister.value = false;
        Get.back();
        Get.back();
        showSuccessSnackbar("Se registró la autorización", "Se recogieron los niños seleccionados");
      } else {
        isLoadingRegister.value = false;
        showErrorSnackbar("No se pudo registrar la autorización", "Por favor vuelva a intentarlo");
      }
    }
    return "";
  }

  bool isNotSelectedChildren(){
    var listCheckedEstudiantes = mainCharger.value.estudiantes!.where((estudiante) => estudiante.checked == false).toList();
    return listCheckedEstudiantes.length == mainCharger.value.estudiantes!.length;
  }
  
  void validateCheckForAll() {
    isCheckForAll.value = (listAuthConfirm.length == mainCharger.value.estudiantes?.length);
    update();
  }

  void checkAllChildren(){
    // Marcar todos los childs
    if(!isCheckForAll.value && mainCharger.value.estudiantes != null){
      mainCharger.value.estudiantes?.forEach((child) { 
        for(var pos = 0; pos < mainCharger.value.estudiantes!.length ; pos++){
          if(!mainCharger.value.estudiantes![pos].checked){
            checkChild(pos);
          }
        }
      });
    } else if(isCheckForAll.value && mainCharger.value.estudiantes != null) {
        for(var pos = 0; pos < mainCharger.value.estudiantes!.length ; pos++){
          if(mainCharger.value.estudiantes![pos].checked){
            checkChild(pos);
          }
        }
      }
  }
  
  
}