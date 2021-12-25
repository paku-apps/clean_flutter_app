import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/features/assign/data_demo.dart';
import 'package:clean_app/features/assign/new_assign_controller.dart';
import 'package:clean_app/widgets/appBars/app_bar_back_nav.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/inputs/input_icon_form_fielld_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class AssignPage extends StatelessWidget {
  
  const AssignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _typeAheadController = TextEditingController();
    String _selectedCity;

    final controllerAssign = Get.put(AssignController());

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), 
        child: AppBarBackNav(
          title: assignPageTitle
        )
      ),
      body: SafeArea(
        child: BackgroundColorSafe(
          colorBackground: colorBackgroundWhite,
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: controllerAssign.isSubmitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                //autovalidateMode:AutovalidateMode.onUserInteraction,
                key: controllerAssign.loginFormkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container( //FormAutocompletado
                      margin: EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
                      child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          const Icon(Icons.account_box, size: 36),
                          Container(
                            padding: const EdgeInsets.only(left: 36),
                            child: TypeAheadFormField(
                              keepSuggestionsOnLoading: false,
                              loadingBuilder: (context) =>
                                Container(
                                  padding:const EdgeInsets.only(left: 36),
                                  height: 60,
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      CircularProgressIndicator()
                                    ]
                                  ),
                                ),
                              // ignore: prefer_const_constructors
                              textFieldConfiguration: TextFieldConfiguration(
                                style: const TextStyle(color: textPrimaryColor, fontSize: 16),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: assignInputCharge),
                              ),
                              suggestionsCallback: (pattern) async {
                                return await BackendService.getSuggestions(pattern);
                              },
                              itemBuilder: (context, Map<String, String> suggestion) {
                                return ListTile(
                                  leading: Icon(Icons.shopping_cart),
                                  title: Text(suggestion['name']!),
                                  subtitle: Text('\$${suggestion['price']}'),
                                );
                              },
                              onSuggestionSelected: (Map<String, String> suggestion) {
                                
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(//Frecuencia
                      margin: EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, size: 36)
                        ],
                      ),
                    )
                  ]
                )
              )
            )
          )
        )
      )
    );
  }
}
