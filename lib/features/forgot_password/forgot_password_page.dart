import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/features/forgot_password/forgot_password_controller.dart';
import 'package:clean_app/widgets/background_color.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/inputs/rounded_input_form_field_pass.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return GetBuilder<ForgotPasswordController>(
      init: ForgotPasswordController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: BackgroundColor(
            colorBackground: colorBackgroundWhite,
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: controller.isSubmitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                //autovalidateMode:AutovalidateMode.onUserInteraction,
                key: controller.changePasswordFormKey,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [  
                  SizedBox(height: size.height * 0.02),
                  //Image.asset("assets/images/app_logo.png", height: size.height * 0.45),
                  TextAppNormal(text: "Por favor ingrese una nueva contraseña",color: textPrimaryColor,),
                  SizedBox(height: size.height * 0.02),
                  RoundedTextFormFieldPass(
                    onChanged: (value) {},
                    functionTapIcon: () => {}, 
                    showPassword: false,
                    labelContrasenia: "Nueva contraseña",
                    controller: controller.firstPasswordController, 
                    leftIcon: Icons.lock,
                    passIsVisible: false,
                    validatorFunction: (value) => controller.validatePass(value),
                    valueData: controller.password,
                  ),
                  SizedBox(height: dimenMedium,),
                  RoundedTextFormFieldPass(
                    onChanged: (value) {},
                    functionTapIcon: () => {}, 
                    showPassword: false,
                    labelContrasenia: "Repetir contraseña",
                    controller: controller.secondPasswordController, 
                    leftIcon: Icons.lock,
                    passIsVisible: false,
                    validatorFunction: (value) => controller.validateRePass(value),
                    valueData: controller.repassword,
                  ), 
                  SizedBox(height: dimenBig,),
                  controller.isLoading? CircularProgressIndicator() : RoundedButton(
                    text: homeChangePassword,
                    color: accentColor, 
                    press: () => controller.checkNewPassword() 
                    //controller.checkLogin
                  ),
                ]
                ),
              )
            )
          )
        )
      )
    );
  }
}