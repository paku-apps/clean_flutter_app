import 'dart:convert';

import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/model/charger.dart';
import 'package:clean_app/features/assign/new_assign_controller.dart';
import 'package:clean_app/utils/extension_utils.dart';
import 'package:clean_app/utils/function_utils.dart';
import 'package:clean_app/widgets/appBars/app_bar_back_nav.dart';
import 'package:clean_app/widgets/avatars/avatar_initials.dart';
import 'package:clean_app/widgets/background/background_color_safe.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/chips/chip_option.dart';
import 'package:clean_app/widgets/custom/children_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class AssignPage extends StatelessWidget {
  
  AssignPage({Key? key}) : super(key: key);
  final TextEditingController _typeAheadController = TextEditingController();

  final assignController = Get.put(AssignController());
  var assignToEdit = null;

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _selectedCity;
    var deviceData = MediaQuery.of(context);

    var listChildCheked = <int>[];

    var argumentitos = Get.arguments;
    if(argumentitos!=null && assignToEdit == null){
      assignController.isToEditAssign.value = true;
      assignToEdit = json.decode(argumentitos[0]);
      assignController.chargerSelectedName.value = assignToEdit["charger"]["ap_paterno"] + emptySpace + assignToEdit["charger"]["ap_materno"]+", "+assignToEdit["charger"]["nombres"];
      assignController.isChargerSelected.value = true;
      assignController.rangeFrecuencyStart.value = assignToEdit["fechaInicio"];
      assignController.rangeFrecuencyEnd.value = assignToEdit["fechaFin"];
      assignController.rangoFrecuenciaCadena.value = assignToEdit["fechaInicio"] +emptySpace+ separatorLine + emptySpace + assignToEdit["fechaFin"];
      assignToEdit["estudiantes"].forEach((chechChild)  {
        if(chechChild["isChecked"]){
          listChildCheked.add(chechChild["id"]);
        }
      });
      assignController.listChildrenToEdit.value = listChildCheked;
      assignController.idAssignToUpdate.value = assignToEdit["id"];
      assignController.idCharger.value = assignToEdit["charger"]["id"];
    }

    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), 
        child: AppBarBackNav(
          title: argumentitos==null ? assignPageTitle : editAssignPageTitle
        )
      ),
      body: SafeArea(
        child: BackgroundColorSafe(
          colorBackground: colorBackgroundWhite,
          child: SingleChildScrollView(
              child: Form(
                autovalidateMode: assignController.isSubmitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                //autovalidateMode:AutovalidateMode.onUserInteraction,
                key: assignController.assignFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container( //FormAutocompletado
                        width: isMobile() ? deviceData.size.width : getResponsiveWidthContainer(deviceData),
                        margin: const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
                        child: Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: [
                            const Icon(Icons.account_box, size: 36),
                            Container(
                              padding: const EdgeInsets.only(left: 36),
                              child: Obx(() { 
                                if (!assignController.isChargerSelected.value && assignController.chargerSelectedName.value.isEmpty) {
                                    return TypeAheadFormField(
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
                                        if(charger.foto!=null){
                                            return ListTile(
                                              leading: Image.network(charger.foto!, height: 48, width: 48,) ,
                                              title: Text(charger.nombres!),
                                              subtitle: Text('${charger.apPaterno} ${charger.apMaterno}'),
                                            );
                                        } else {
                                          return ListTile(
                                              leading: AvatarCircleInitials(firstName: charger.nombres!, lastName: charger.apPaterno!,),
                                              title: Text(charger.nombres!),
                                              subtitle: Text('${charger.apPaterno} ${charger.apMaterno}'),
                                            ); 
                                        }
                                      },
                                      noItemsFoundBuilder: (context) => Container(
                                        padding: const EdgeInsets.all(8),
                                        child: const Text("No se encontraron responsables")
                                        ),
                                      onSuggestionSelected: (Charger charger) {
                                          _typeAheadController.text = charger.apPaterno! + separatorComma + emptySpace+ charger.nombres!;
                                          assignController.selectedCharger(charger.id!, _typeAheadController.text);
                                          //assignController.idCharger.value = charger.id!;
                                      },
                                    );
                                  } else {
                                    return ChipOption(text: assignController.chargerSelectedName.value , press: () {
                                      _typeAheadController.text = emptyString;
                                      assignController.clearCharger();
                                    });
                                  }
                              })
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(//Frecuencia
                      width: isMobile() ? deviceData.size.width : getResponsiveWidthContainer(deviceData),
                      child: Obx((){
                        return Row(
                          children: [
                            const SizedBox(width: 4),
                            Checkbox(value: assignController.checkForever.value, onChanged: (value) {
                              assignController.checkForeverRange();
                            },),
                            const Text(assignForever),
                          ],
                        );
                      })
                    ),
                    //SfDateRangePicker(),
                    Obx((){
                      return Container(//Frecuencia
                        width: isMobile() ? deviceData.size.width : getResponsiveWidthContainer(deviceData),
                        margin: const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
                        child: assignController.checkForever.value ? const SizedBox(height: 8) : Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 36),
                            Expanded(
                              child: InkWell(
                                  onTap: () async {
                                    var initialDateRate = DateTimeRange(start: DateTime.now(), end: DateTime.now());
                                    var selectedRange = await showDateRangePicker(context: context, initialDateRange: initialDateRate, firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year+2));
                                    if(selectedRange!=null){
                                      assignController.rangeFrecuencyStart.value = transformDateTimeToFormatBackend(selectedRange.start);
                                      assignController.rangeFrecuencyEnd.value = transformDateTimeToFormatBackend(selectedRange.end);
                                      assignController.rangoFrecuenciaCadena.value = transformDateTimeToFormat(selectedRange.start) + emptySpace + separatorLine + emptySpace + transformDateTimeToFormat(selectedRange.end);
                                    }
                                  },
                                  child: SizedBox(
                                  height: 48,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black38),
                                      borderRadius: const BorderRadius.all(Radius.circular(4))
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
                      );
                    }),
                    const Text("Seleccione a quién recogerá:", textAlign: TextAlign.start, style: TextStyle(fontSize: textSizeNormalLabel)),
                    Container(//Lista de niño
                      margin: const EdgeInsets.fromLTRB(dimenSmall, dimenSmall, dimenSmall, dimenSmall),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  isMobile()?
                                    Expanded(
                                      child: ChildTile(
                                          child: assignController.listChildren[index], hasCheckBox: true
                                      ),
                                    ) : 
                                    ChildTile(
                                        child: assignController.listChildren[index], hasCheckBox: true
                                    ),
                                  Checkbox(value: assignController.listChildren[index].isChecked, onChanged: (value) {
                                    assignController.checkChild(index, value!);
                                  })
                                ]
                              );
                            }
                          )
                      )
                    ),
                    Obx((){
                      if(!assignController.isLoading.value){
                        return RoundedButton(
                          text: assignToEdit == null ? registerAssignButton : updateAssignButton, 
                          press: () {
                            if(assignToEdit==null){
                              assignController.submitNewAssign();
                            }else {
                              assignController.updateAssign();
                            }
                          }
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    })
                    
                  ]
                )
              )
            )
          )
        )
    );
  }
}