import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/features/assign/data_demo.dart';
import 'package:clean_app/features/assign/new_assign_controller.dart';
import 'package:clean_app/widgets/appBars/app_bar_back_nav.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/inputs/input_icon_form_fielld_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
                    //SfDateRangePicker(),
                    Container(//Frecuencia
                      width: size.width,
                      margin: EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 36),
                          Expanded(
                            child: InkWell(
                                onTap: () {
                                  var initialDateRate = DateTimeRange(start: DateTime.now(), end: DateTime.now());
                                  showDateRangePicker(context: context, initialDateRange: initialDateRate, firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year+2));
                                } ,
                                child: SizedBox(
                                height: 48,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38),
                                    borderRadius: BorderRadius.all(Radius.circular(4))
                                  ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [
                                        const SizedBox(width: 8),
                                        const Text(
                                          assignInputFrecuency,
                                          textAlign: TextAlign.start,
                                      )
                                      ]
                                    ),
                                  ),
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(//Lista de niños
                      width: size.width,
                      margin: EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
                      child: Row(
                        children: [
                          Icon(Icons.supervised_user_circle_rounded, size: 36),
                          Expanded(
                            child: Text("DEMO")
                          ),
                          Checkbox(value: true, onChanged: (value) {

                          })
                        ],
                      ),
                    ),
                    RoundedButton(
                      text: registerAssignButton, 
                      press: () {}
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
