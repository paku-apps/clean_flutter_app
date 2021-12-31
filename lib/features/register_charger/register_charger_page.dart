import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/features/register_charger/register_charger_controller.dart';
import 'package:clean_app/widgets/appBars/app_bar_back_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RegisterChargerPage extends StatelessWidget {
  const RegisterChargerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<RegisterChargerController>(
      init: RegisterChargerController(),
      builder: (registerChargerController) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56), 
          child: AppBarBackNav(
            title: registerAuthorization
          )
        ),
        body: Center(
          child: Text("DEMITO REGISTER CHARGER"),
        )
      )
    );
  }
}