import 'package:clean_app/data/model/charger.dart';
import 'package:clean_app/data/repository/charger_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AssignController extends GetxController {

  var isSubmitted = false.obs();
  String tokenStored = "";
  
  final GlobalKey<FormState> loginFormkey = GlobalKey<FormState>().obs();
  late TextEditingController emailController, passwordController;
  var responsable = "".obs();

  
  @override 
  void onInit(){
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

    @override 
  void onClose(){
    emailController.dispose();
    passwordController.dispose();
  }

  Future<List<Charger>> searchChargerByPattern(String pattern) async {
    UserRepository repoUsuario = UserRepositoryImpl();
    tokenStored = await repoUsuario.getToken();
    ChargerRepository repo = ChargerRepositoryImpl();
    List<Charger> list = await repo.getListChargerSearch(tokenStored, pattern);
    return list;
  }



}