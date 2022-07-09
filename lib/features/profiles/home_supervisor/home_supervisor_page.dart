
import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/features/profiles/home_supervisor/home_supervisor_controller.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/drawers/drawer_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class HomeSupervisorPage extends StatelessWidget {
  const HomeSupervisorPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final controllerPage = Get.put(HomeSupervisorController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), 
        child: AppBarDrawerApp(
          title: homeSupervisorPageTitle,
        )
      ),
      drawer: Obx((){
        return HeaderFooterDrawerApp(
          user: controllerPage.usuarioLogged.value,
          listIcons: const [Icon(Icons.home)],
          listNames: const [draweroptionsHome],
          listFunctions: [() => {Navigator.pop(context)}],
          closeFunction: controllerPage.closeSession,
        );
      }),
      body: SafeArea(
          child: BackgroundColorSafe(
            colorBackground: colorBackgroundWhite,
            child: Obx(() {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RoundedButton(
                        text: homeSupervisorScanQR, 
                        press: () async {
                          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                                                        '#ff6666', 
                                                        "Cancelar", 
                                                        false, 
                                                        ScanMode.QR);
                          if(barcodeScanRes!= "-1"){controllerPage.goToInfoAuth(barcodeScanRes);}
                        }
                      ),
                      Text(controllerPage.valueQR.value, style: const TextStyle(color: whiteColor),),
                      //TextLabelTap(press: () => {Get.toNamed(AppLinks.INFO_AUTH)}, textLabel: "Detail Authorization")
                     ]
                  )
                );
              })
          )
      ),
    );
  }
}