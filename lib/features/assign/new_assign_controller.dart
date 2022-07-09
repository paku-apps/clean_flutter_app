import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/charger.dart';
import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/assign_repository.dart';
import 'package:clean_app/data/repository/charger_repository.dart';
import 'package:clean_app/data/repository/child_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/features/list_assigns/list_assign_controller.dart';
import 'package:clean_app/utils/function_utils.dart';
import 'package:clean_app/widgets/snackbars/snackbar_get_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignController extends GetxController {

  final ListAssignController listAssignController = Get.find();

  var isSubmitted = false.obs();
  String tokenStored = "";
  //UI
  var isLoading = false.obs;
  var isChargerSelected = false.obs;
  var chargerSelectedName = "".obs;
  var isLoadedFromEdit = false.obs;
  
  final GlobalKey<FormState> assignFormKey = GlobalKey<FormState>().obs();
  var responsable = "".obs();
  var rangoFrecuenciaCadena = "".obs;
  var listChildren = List<Child>.empty().obs;
  var usuarioLogged = User().obs;
  var checkForever = false.obs;

  //Data for Backend
  var rangeFrecuencyStart = "".obs;
  var rangeFrecuencyEnd = "".obs;
  var idCharger = 0.obs;
  var idApoderado = 0.obs;

  //Data for edit
  var isToEditAssign = false.obs;
  var listChildrenToEdit = List<int>.empty().obs;
  var idAssignToUpdate = 0.obs;
  
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
      idApoderado.value = currentUser.id;
    }
    return currentUser;
  }
  
  @override 
  void onClose(){

  }

  Future<List<Charger>> searchChargerByPattern(String pattern) async {
    UserRepository repoUsuario = UserRepositoryImpl();
    tokenStored = await repoUsuario.getToken();
    ChargerRepository repo = ChargerRepositoryImpl();
    List<Charger> list = await repo.getListChargerSearch(tokenStored, pattern);
    return list;
  }

  void checkChild(int position, bool isCheck){
    listChildren.value[position].isChecked = isCheck;
    update();
  }
  
  Future<List<Child>?> getChildren() async {
    UserRepository repoUsuario = UserRepositoryImpl();
    tokenStored = await repoUsuario.getToken();
    ChildRepository repo = ChildRepositoryImpl();
    var idApoderado = usuarioLogged.value.id;
    List<Child>? list = await repo.getListChildForAssign(tokenStored, idApoderado);
    if(list!=null){
      listChildren.value = list;
      validateIsForEdit();
    }
    update();
    return list;
    
  }

  void validateIsForEdit(){
    if(isToEditAssign.value) {
      for (var child in listChildren.value) { 
        if(listChildrenToEdit.contains(child.id)){
          child.isChecked = true;
        }
      }
    }
  }

  void checkForeverRange(){
    checkForever.value = !checkForever.value;
    update();
  }

  void submitNewAssign() async {
    isLoading.value = true;
    var listaChilds = listChildren.value.where((child) => child.isChecked);
    var start = checkForever.value ? transformDateTimeToFormatBackend(DateTime.now()) : rangeFrecuencyStart.value;
    var end = checkForever.value ? transformDateTimeToFormatForeverBackend(DateTime.now()) : rangeFrecuencyEnd.value;
    var apoderado = idApoderado.value;
    var responsable = idCharger.value;
    tokenStored;
    
    var assignRepository = AssignRepositoryImpl();
    try{
      if(apoderado == responsable) {
        throw AssignRepositoryException(message: errorMessageSameUser);
      }
      if(responsable == 0){
        throw AssignRepositoryException(message: errorMessageNoChargerSelected);
      }
      if(listaChilds.isEmpty){
        throw AssignRepositoryException(message: errorMessageNoChilsSelected);
      }
      var responseSubmit = await assignRepository.submitAssign(tokenStored, responsable, apoderado, start, end, listaChilds);
      isLoading.value = false;
      Get.back();
      Get.back();
      listAssignController.reloadData();
      showSuccessSnackbar("Se registró la autorización", "Se le notificará al responsable");
    } on AssignRepositoryException catch(e){
      showErrorSnackbar("Aviso", e.message);
      isLoading.value = false;
    }
  }

  void updateAssign() async {
    isLoading.value = true;
    var start = checkForever.value ? transformDateTimeToFormatBackend(DateTime.now()) : rangeFrecuencyStart.value;
    var end = checkForever.value ? transformDateTimeToFormatForeverBackend(DateTime.now()) : rangeFrecuencyEnd.value;
    var apoderado = idApoderado.value;
    var listaChilds = listChildren.value.where((child) => child.isChecked);
    var responsable = idCharger.value;
    
    var assignRepository = AssignRepositoryImpl();
    try{
      if(apoderado == responsable) {
        throw AssignRepositoryException(message: errorMessageSameUser);
      }
      if(responsable == 0){
        throw AssignRepositoryException(message: errorMessageNoChargerSelected);
      }
      if(listaChilds.isEmpty){
        throw AssignRepositoryException(message: errorMessageNoChilsSelected);
      }
      var responseUpdated = await assignRepository.updateAssign(tokenStored, idAssignToUpdate.value, responsable, apoderado, start, end, listaChilds);
      isLoading.value = false;
      listAssignController.reloadData();
      Get.back();
      Get.back();
      showSuccessSnackbar("Se actualizó la autorización", "Se le notificará al responsable");
      
    } on AssignRepositoryException catch(e){
      showErrorSnackbar("Aviso", e.message);
      isLoading.value = false;
    }
  }

  void selectedCharger(int i, String nameCharger) {
    idCharger.value = i;
    isChargerSelected.value = true;
    chargerSelectedName.value = nameCharger;
    update();
  }

  void clearCharger() {
    idCharger.value = 0;
    isChargerSelected.value = false;
    chargerSelectedName.value = emptyString;
    if(isToEditAssign.value){

    }
    update();
  }


}