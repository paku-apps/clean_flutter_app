import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/charger.dart';
import 'package:clean_app/features/assign/data_demo.dart';
import 'package:clean_app/features/assign/new_assign_controller.dart';
import 'package:clean_app/utils/function_utils.dart';
import 'package:clean_app/widgets/appBars/app_bar_back_nav.dart';
import 'package:clean_app/widgets/appBars/app_bar_drawer.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/custom/children_tile.dart';
import 'package:clean_app/widgets/inputs/input_icon_form_fielld_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AssignPage extends StatelessWidget {
  
  AssignPage({Key? key}) : super(key: key);
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _selectedCity;

    final assignController = Get.put(AssignController());

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
              child: Form(
                autovalidateMode: assignController.isSubmitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                //autovalidateMode:AutovalidateMode.onUserInteraction,
                key: assignController.loginFormkey,
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
                              minCharsForSuggestions: 3,
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
                                controller: _typeAheadController,
                                style: const TextStyle(color: textPrimaryColor, fontSize: 16),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: assignInputCharge),
                              ),
                              suggestionsCallback: (pattern) async {
                                return assignController.searchChargerByPattern(pattern);
                              },
                              itemBuilder: (context, Charger charger) {
                                return ListTile(
                                  leading: Image.network(charger.foto!, height: 48, width: 48,),
                                  title: Text(charger.nombres!),
                                  subtitle: Text('${charger.apPaterno} ${charger.apMaterno}'),
                                );
                              },
                              noItemsFoundBuilder: (context) => Container(
                                padding: EdgeInsets.all(8),
                                child:Text("No se encontraron responsables")
                                ),
                              onSuggestionSelected: (Charger charger) {
                                  _typeAheadController.text = charger.apPaterno! + separatorComma + emptySpace+ charger.nombres!;
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
                          const Icon(Icons.calendar_today, size: 36),
                          Expanded(
                            child: InkWell(
                                onTap: () async {
                                  var initialDateRate = DateTimeRange(start: DateTime.now(), end: DateTime.now());
                                  var selectedRange = await showDateRangePicker(context: context, initialDateRange: initialDateRate, firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year+2));
                                  assignController.rangoFrecuenciaCadena.value = transformDateTimeToFormat(selectedRange!.start) + emptySpace + separatorLine + emptySpace + transformDateTimeToFormat(selectedRange.end);
                                },
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
                                      children: [
                                        const SizedBox(width: 8),
                                        Obx(() {
                                          if(assignController.rangoFrecuenciaCadena.isNotEmpty){
                                            return Text(
                                              assignController.rangoFrecuenciaCadena.toString(),
                                              textAlign: TextAlign.start,
                                            ); 
                                          } else {      
                                            return const Text(
                                              assignInputFrecuency,
                                              textAlign: TextAlign.start,
                                            );
                                          }
                                        }),
                                      ]
                                    ),
                                  ),
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("Seleccione a quién recogerá:", textAlign: TextAlign.start, style: TextStyle(fontSize: textSizeNormalLabel)),
                    Container(//Lista de niños
                      width: size.width,
                      margin: EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
                      child: GetBuilder<AssignController>(
                        init: AssignController(),
                        builder: (assignController) =>
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: assignController.listChildren.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: ChildTile(
                                        child: assignController.listChildren[index],
                                    ),
                                  ),
                                  Checkbox(value: assignController.listChildren[index].isChecked, onChanged: (value) {
                                    assignController.checkChild(index);
                                  })
                                ]
                              );
                            }
                          )
                      )
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
    );
  }
}


/*
ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: assignController.listChildren.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: ChildTile(
                                        child: assignController.listChildren[index],
                                      ),
                                  ),
                                  Checkbox(value: assignController.listChildren[index].isChecked, onChanged: (value) {
                                    assignController.checkChild(index);
                                  })
                                ]
                              );
                            }
                          ),
*/