
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer.dart';
import 'package:clean_app/widgets/drawers/drawer_app.dart';
import 'package:flutter/material.dart';

class HomeSupervisorPage extends StatelessWidget {
  const HomeSupervisorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), 
        child: AppBarDrawerApp(
          title: homeSupervisorPageTitle,
        )
      ),
      //drawer: HeaderFooterDrawerApp(user: User(name: "Primero", lastName: "Segundo", email: "Correo"),),
      body: const Center(
        child: Text('Profile Supervisor'),
      ),
    );
  }
}