import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/features/detail_charger_qr/detail_charger_qr_controller.dart';
import 'package:clean_app/widgets/appBars/app_bar_back_nav.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailChargerQrPage extends StatelessWidget {
  const DetailChargerQrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final controllerChargerDetailQR = Get.put(DetailChargerQRController());
    
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), 
        child: AppBarBackNav(
          title: homeChargerPageDetailQR,
        ),
      ),
      body: SafeArea(
          child: BackgroundColorSafe(
            colorBackground: colorBackgroundWhite,
            child: SingleChildScrollView(
              child: Column (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.01),
                  TextAppNormal(text: homeFatherPageTextQr, color: textPrimaryColor),
                  Container(
                    width: size.width,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() {
                          if(controllerChargerDetailQR.showQR == true){
                            return QrImage(
                              data: controllerChargerDetailQR.qrDetail.string,
                              version: QrVersions.auto,
                              size: 280
                            );
                          } if(controllerChargerDetailQR.showQRLoading == true) {
                            return CircularProgressIndicator();
                          } else{
                            return Text("Cargando Autorización");
                          }
                        }),
                      ],
                    ),
                  )
                ]
              )
          )
      )
    ));
  }
}