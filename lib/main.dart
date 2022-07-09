import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:clean_app/features/login/auth/authentication_service.dart';
import 'package:clean_app/features/login/auth/authentication_state.dart';
import 'package:clean_app/features/login/login_page.dart';
import 'package:clean_app/features/profiles/home_charge/home_charge_page.dart';
import 'package:clean_app/features/profiles/home_father/home_father_page.dart';
import 'package:clean_app/features/profiles/home_supervisor/home_supervisor_page.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/features/demo/demo_page.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  initialize();
  runApp(MyApp());
}

void initialize(){
  //Load all controllers
  Get.lazyPut(() => AuthenticationController(Get.put(AuthenticationServiceImpl())),);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AuthenticationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var homePage;
    return GetMaterialApp(
      title: 'PickMeApp',
      onGenerateTitle: (BuildContext context) {
        return "PickMeApp";
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        if(controller.state is Authenticated){
          if((controller.state as Authenticated).user.perfil == 1){
            return const DemoPage();
          }
          if((controller.state as Authenticated).user.perfil == 2){
            return const HomeFatherPage();
          }
          if((controller.state as Authenticated).user.perfil == 3){
            return const HomeChargePage();
          }
          if((controller.state as Authenticated).user.perfil == 4){
            return const HomeSupervisorPage();
          }
        }
        if(controller.state is UnAuthenticated){
          return const LoginPage();
        }
        return const SafeArea(
          child: BackgroundColorSafe(
            colorBackground: colorBackgroundWhite,
            child: Center(
              child: CircularProgressIndicator(),
            )
          )
        );
      }),
    );
  }
}