
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/widgets/appBars/app_bar.dart';
import 'package:clean_app/widgets/drawers/drawer_app.dart';
import 'package:flutter/material.dart';

class HomeFatherPage extends StatelessWidget {
  const HomeFatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), 
        child: AppBarDrawerApp(
          title: homeFatherPageTitle,
        )
      ),
      drawer: HeaderFooterDrawerApp(),
      body: const Center(
        child: Text('Profile Father'),
      ),
    );
  }
}