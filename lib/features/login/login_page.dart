import 'package:clean_app/controllers/login/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) => const Scaffold(
        body: Center(
          child: Text("Login Page")
        ),
      ),
    );
  }
}