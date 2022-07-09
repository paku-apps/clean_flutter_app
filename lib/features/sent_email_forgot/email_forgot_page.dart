import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/features/sent_email_forgot/email_forgot_controller.dart';
import 'package:clean_app/widgets/background_color.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/inputs/rounded_input_form_field_normal.dart';
import 'package:clean_app/widgets/texts/text_app_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailForgotPage extends StatelessWidget {
EmailForgotPage({Key? key}) : super(key: key);

final controller = Get.put(EmailForgotController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
        body: SafeArea(
          child: BackgroundColor(
            colorBackground: colorBackgroundWhite,
            child: SingleChildScrollView(
              child: Form(
                  autovalidateMode: controller.isSubmitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  //autovalidateMode:AutovalidateMode.onUserInteraction,
                  key: controller.changeEmailForgot,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [  
                    SizedBox(height: size.height * 0.02),
                    //Image.asset("assets/images/app_logo.png", height: size.height * 0.45),
                    TextAppNormal(text: "Por favor ingrese una nueva contraseña",color: textPrimaryColor,),
                    SizedBox(height: size.height * 0.02),
                    RoundedTextFormFieldNormal(
                      onChanged: (value) {},
                      showPassword: false,
                      controller: controller.emailController, 
                      leftIcon: Icons.lock,
                      validatorFunction: (value) => controller.validateEmail(value),
                      valueData: controller.email
                    ),
                    const SizedBox(height: dimenBig,),
                    Container(
                      child: Obx(() {
                        if(controller.isLoading.value) {
                          return const CircularProgressIndicator();
                        } else {
                          return RoundedButton(
                            text: homeResetPassword,
                            color: accentColor, 
                            press: () => controller.checkEmail() 
                          );
                        } 
                    }),
                    )
                  ]
                ),
              )
            )
          )
        )
      );
  }
}