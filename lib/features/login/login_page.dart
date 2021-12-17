import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimentsions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:clean_app/features/login/auth/authentication_service.dart';
import 'package:clean_app/features/login/login_controller.dart';
import 'package:clean_app/widgets/background_color.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/inputs/rounded_input_form_field_normal.dart';
import 'package:clean_app/widgets/inputs/rounded_input_form_field_pass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
    
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: BackgroundColor(
            colorBackground: colorBackgroundWhite,
            child: SingleChildScrollView(
              child: Form(
                //autovalidateMode: controller.isSubmitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                autovalidateMode:AutovalidateMode.onUserInteraction,
                key: controller.loginFormkey,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [    
                  SizedBox(height: size.height * 0.10),
                  SvgPicture.asset(
                    "assets/images/rocket_app.svg",
                    height: size.height * 0.25,
                  ),
                  SizedBox(height: size.height * 0.10),
                  RoundedTextFormFieldNormal(
                    onChanged: (value) {},
                    controller: controller.emailController, 
                    leftIcon: Icons.account_circle_rounded,
                    validatorFunction: (value) => controller.validateEmail(value),
                    valueData: controller.email,
                  ),
                  const SizedBox(height: dimenMedium),
                  RoundedTextFormFieldPass(
                    onChanged: (value) {},
                    functionTapIcon: () => controller.changePassVisibility(), 
                    showPassword: controller.passVisibility,
                    controller: controller.passwordController, 
                    leftIcon: Icons.lock,
                    validatorFunction: (value) => controller.validatePassword(value),
                    valueData: controller.password,
                  ),
                  const SizedBox(height: dimenMedium),
                  RoundedButton(
                    text: loginPageButtonLogin,
                    color: accentColor, 
                    press: () => controller.checkLogin() 
                    //controller.checkLogin
                  ),
                  SizedBox(height: size.height * 0.10),
                ],
              ),
              )
            ),
          ),
        )
      ),
    );
  }
}