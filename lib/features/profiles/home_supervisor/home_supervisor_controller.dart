import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class HomeSupervisorController extends GetxController {
  final AuthenticationController _authenticationController = Get.find();

  var isLoadingScreen = false.obs;
  var valueQR = "".obs;

  void scanQR() async {
    valueQR.value = await FlutterBarcodeScanner.scanBarcode('#ff6666', "Cancelar", false, ScanMode.QR);
  }

  Future<void> closeSession() async {
    _authenticationController.signOut();
    UserRepository repoUsuario = UserRepositoryImpl();
    await repoUsuario.clearDataUser();
  }
}