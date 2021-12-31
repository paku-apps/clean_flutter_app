import 'package:clean_app/features/assign/new_assign_page.dart';
import 'package:clean_app/features/demo/demo_page.dart';
import 'package:clean_app/features/list_assigns/list_assign_page.dart';
import 'package:clean_app/features/info_authorization/info_auth_page.dart';
import 'package:clean_app/features/login/login_page.dart';
import 'package:clean_app/features/profiles/home_charge/home_charge_page.dart';
import 'package:clean_app/features/profiles/home_father/home_father_page.dart';
import 'package:clean_app/features/profiles/home_supervisor/home_supervisor_page.dart';
import 'package:clean_app/features/register_charger/register_charger_page.dart';
import 'package:get/get.dart';

class AppRoutes {

  static final pages = [
    GetPage(name: AppLinks.DEMO, page: () => DemoPage()),
    GetPage(name: AppLinks.LOGIN, page: () => LoginPage()),
    GetPage(name: AppLinks.HOME_FATHER, page: () => HomeFatherPage()),
    GetPage(name: AppLinks.HOME_CHARGE, page: () => HomeChargePage()),
    GetPage(name: AppLinks.HOME_SUPERVISOR, page: () => HomeSupervisorPage()),
    GetPage(name: AppLinks.NEW_ASSIGN, page: () => AssignPage()),
    GetPage(name: AppLinks.LIST_ASSIGNS, page: () => ListAssignPage()),
    GetPage(name: AppLinks.INFO_AUTH, page: () => InfoAuthorizationPage()),
    GetPage(name: AppLinks.REGISTER_CHARGER, page: () => RegisterChargerPage())
  ];

}

class AppLinks {
  static const String DEMO = "/demo";
  static const String LOGIN = "/login";
  static const String HOME_FATHER = "/home/father";
  static const String HOME_CHARGE = "/home/charge";
  static const String HOME_SUPERVISOR = "/home/supervisor";

  
  static const String NEW_ASSIGN = "/newassign";
  static const String LIST_ASSIGNS = "/listassigns";
  static const String INFO_AUTH = "/infoauthorization";


  static const String REGISTER_CHARGER = "/register/charger";
}