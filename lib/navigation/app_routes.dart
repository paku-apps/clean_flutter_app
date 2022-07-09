import 'package:clean_app/features/assign/new_assign_page.dart';
import 'package:clean_app/features/demo/demo_page.dart';
import 'package:clean_app/features/detail_assign/detail_assign_page.dart';
import 'package:clean_app/features/detail_charger_qr/detail_charger_qr_page.dart';
import 'package:clean_app/features/forgot_password/forgot_password_page.dart';
import 'package:clean_app/features/list_assigns/list_assign_page.dart';
import 'package:clean_app/features/info_authorization/info_auth_page.dart';
import 'package:clean_app/features/login/login_page.dart';
import 'package:clean_app/features/profiles/home_charge/home_charge_page.dart';
import 'package:clean_app/features/profiles/home_father/home_father_page.dart';
import 'package:clean_app/features/profiles/home_supervisor/home_supervisor_page.dart';
import 'package:clean_app/features/register_charger/register_charger_page.dart';
import 'package:clean_app/features/sent_email_forgot/email_forgot_page.dart';
import 'package:clean_app/main.dart';
import 'package:get/get.dart';

class AppRoutes {

  static final pages = [
    GetPage(name: AppLinks.MAIN_PAGE, page: () => MyApp()),
    GetPage(name: AppLinks.DEMO, page: () => const DemoPage()),
    GetPage(name: AppLinks.LOGIN, page: () => const LoginPage()),
    GetPage(name: AppLinks.HOME_FATHER, page: () => const HomeFatherPage()),
    GetPage(name: AppLinks.HOME_CHARGE, page: () => const HomeChargePage()),
    GetPage(name: AppLinks.HOME_SUPERVISOR, page: () => const HomeSupervisorPage()),
    GetPage(name: AppLinks.NEW_ASSIGN, page: () => AssignPage()),
    GetPage(name: AppLinks.LIST_ASSIGNS, page: () => const ListAssignPage()),
    GetPage(name: AppLinks.INFO_AUTH, page: () => const InfoAuthorizationPage()),
    GetPage(name: AppLinks.REGISTER_CHARGER, page: () => const RegisterChargerPage()),
    GetPage(name: AppLinks.DETAIL_ASSIGN, page: () => DetailAssignPage()),
    GetPage(name: AppLinks.CHARGER_QR, page: () => const DetailChargerQrPage()),
    GetPage(name: AppLinks.FORGOT_PAGE, page: () => ForgotPasswordPage()),
    GetPage(name: AppLinks.RESET_PASSWORD, page: () => EmailForgotPage())
  ];

}

class AppLinks {
  static const String MAIN_PAGE = "/";
  static const String DEMO = "/demo";
  static const String LOGIN = "/login";
  static const String HOME_FATHER = "/home/father";
  static const String HOME_CHARGE = "/home/charge";
  static const String HOME_SUPERVISOR = "/home/supervisor";

  
  static const String NEW_ASSIGN = "/newassign";
  static const String LIST_ASSIGNS = "/listassigns";
  static const String INFO_AUTH = "/infoauthorization";
  static const String DETAIL_ASSIGN = "/detail";


  static const String REGISTER_CHARGER = "/register/charger";

  
  static const String CHARGER_QR = "/home/charge/generatedqr";

  static const String DETAIL_SUPERVISOR_QR = "/home/supervisor/qr/detail";
  static const String FORGOT_PAGE = "/forgotpassword";
  static const String RESET_PASSWORD = "/reset";
}