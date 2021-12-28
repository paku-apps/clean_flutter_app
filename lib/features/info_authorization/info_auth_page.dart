import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/features/info_authorization/info_auth_controller.dart';
import 'package:clean_app/widgets/appBars/app_bar_back_nav.dart';
import 'package:clean_app/widgets/avatars/avatar_initials.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/texts/text_app_normal_bold.dart';
import 'package:clean_app/widgets/texts/text_app_title.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class InfoAuthorizationPage extends StatelessWidget {
  const InfoAuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infoController = Get.put(InfoAuthorizationController());

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), 
        child: AppBarBackNav(
          title: infoAuthorizationTitle
        )
      ),
      body: SafeArea(
        child: BackgroundColorSafe(
          colorBackground: colorBackgroundWhite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextAppNormalBold(
                  text: infoAuthorizationCharger,
                  color: textPrimaryColor,
                  noPaddingVertical: false
                ),
                /*
                AvatarCircleInitials(
                  firstName: firstName, 
                  lastName: lastName
                ),*/

                TextAppNormalBold(
                  text: infoAuthorizationChildren,
                  color: textPrimaryColor,
                  noPaddingVertical: false
                )
              ],
            ),
          )
        )
      )
    );
  }
}