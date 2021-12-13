import 'package:clean_app/features/login/login_page.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/features/demo_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  initialize();
  runApp(const MyApp());
}

void initialize(){

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clean App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}