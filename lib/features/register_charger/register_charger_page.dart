import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/features/register_charger/register_charger_controller.dart';
import 'package:clean_app/widgets/appBars/app_bar_back_nav.dart';
import 'package:clean_app/widgets/avatars/avatar_profile_picker.dart';
import 'package:clean_app/widgets/avatars/circle_avatar_asset.dart';
import 'package:clean_app/widgets/avatars/circle_avatar_file.dart';
import 'package:clean_app/widgets/background_color.dart';
import 'package:clean_app/widgets/inputs/input_icon_form_fielld_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

class RegisterChargerPage extends StatelessWidget {
  const RegisterChargerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var imagedTaked;
    

    return GetBuilder<RegisterChargerController>(
      init: RegisterChargerController(),
      builder: (registerChargerController) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56), 
          child: AppBarBackNav(
            title: registerAuthorization
          )
        ),
        body: SafeArea(
          child: BackgroundColor(
            colorBackground: colorBackgroundWhite,
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: registerChargerController.isSubmitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                //autovalidateMode:AutovalidateMode.onUserInteraction,
                key: registerChargerController.regiterChargerFormkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [ 
                    AvatarProfilePicker(
                      pictureTaked: registerChargerController.imageFileTaked,
                      functionProfile: () { registerChargerController.takePicture(); },
                    ),
                    TextFormFieldIconNormal(
                      onChanged: (value) {},
                      controller: registerChargerController.nameController, 
                      validatorFunction: (value) {registerChargerController.validateNombres(value);}
                    ),
                  ]
                )
              )
            )
          )
        )
      )
    );
  }
}