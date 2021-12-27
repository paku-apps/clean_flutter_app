import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class HomeSupervisorController extends GetxController {

  var isLoadingScreen = false.obs;
  var valueQR = "".obs;

  void scanQR() async {
    valueQR.value = await FlutterBarcodeScanner.scanBarcode('#ff6666', "Cancelar", false, ScanMode.QR);
  }

}