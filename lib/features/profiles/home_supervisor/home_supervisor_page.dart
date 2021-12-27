
import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/features/profiles/home_supervisor/home_supervisor_controller.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/drawers/drawer_app.dart';
import 'package:clean_app/widgets/labels/label_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeSupervisorPage extends StatelessWidget {
  HomeSupervisorPage({Key? key}) : super(key: key);

  final controllerPage = Get.put(HomeSupervisorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), 
        child: AppBarDrawerApp(
          title: homeSupervisorPageTitle,
        )
      ),
      drawer: HeaderFooterDrawerApp(user: User(name: "Primero", lastName: "Segundo", email: "Correo"),),
      body: SafeArea(
          child: BackgroundColorSafe(
            colorBackground: colorBackgroundWhite,
            child: SingleChildScrollView(
              child: Obx(() {
                return Column(
                  children: [
                    RoundedButton(
                      text: homeSupervisorScanQR, 
                      press: () async {
                        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                                                      '#ff6666', 
                                                      "Cancelar", 
                                                      false, 
                                                      ScanMode.QR);
                      }
                    ),
                    Text(controllerPage.valueQR.value),
                    TextLabelTap(press: () => {Get.toNamed(AppLinks.INFO_AUTH)}, textLabel: "Detail Authorization")
                  
                   ]
                );
              })
            )
          )
      ),
    );
  }
}