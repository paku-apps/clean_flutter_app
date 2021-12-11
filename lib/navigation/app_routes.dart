import 'package:clean_app/pages/demo_page.dart';
import 'package:clean_app/pages/login/login_page.dart';
import 'package:get/get.dart';

class AppRoutes {

  static final pages = [
    GetPage(name: AppLinks.DEMO, page: ()=> DemoPage()),
    GetPage(name: AppLinks.LOGIN, page: ()=> LoginPage())
  ];

}

class AppLinks {
  static const String DEMO = "/demo";
  static const String LOGIN = "/login";
}