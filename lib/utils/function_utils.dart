import 'package:clean_app/constants/text_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void openBrowser(
  String urlString
) async {
  if(!await launch(urlString)) throw messageNotLaunchUrl;
}

String getInitialString(String text){
  if(text.isNotEmpty){
    return text[0];
  } else {
    return emptyString;
  }
}

String transformDateTimeToFormat(DateTime dateTime){
  return DateFormat('dd-MM-yyyy').format(dateTime);
  //return dateTime.day.toString() + separatorSlash + dateTime.month.toString() + separatorSlash + dateTime.year.toString(); 
  //return dateTime.year.toString() + separatorSlash + dateTime.month.toString() + separatorSlash + dateTime.day.toString(); 
}

String transformDateTimeToFormatBackend(DateTime dateTime){
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

String transformDateTimeToAppFormat(DateTime startDateTime, DateTime endDateTime){
  var start =  DateFormat('dd MMMM, yyyy').format(startDateTime);
  var end =  DateFormat('dd MMMM, yyyy').format(endDateTime);
  return "Desde " + start + " hasta el " + end;
  //return dateTime.day.toString() + separatorSlash + dateTime.month.toString() + separatorSlash + dateTime.year.toString(); 
  //return dateTime.year.toString() + separatorSlash + dateTime.month.toString() + separatorSlash + dateTime.day.toString(); 
}

String transformStringDateTimeToAppFormat(String startDateTime, String endDateTime){
  initializeDateFormatting();
  var dateTimeStart = DateFormat("dd-MM-yyyy").parse(startDateTime);
  var dateTimeEnd = DateFormat("dd-MM-yyyy").parse(endDateTime);
  var start =  DateFormat('dd MMMM, yyyy', "es_US").format(dateTimeStart);
  var end =  DateFormat('dd MMMM, yyyy', "es_US").format(dateTimeEnd);
  return "Desde " + start + " hasta el " + end;
  //return dateTime.day.toString() + separatorSlash + dateTime.month.toString() + separatorSlash + dateTime.year.toString(); 
  //return dateTime.year.toString() + separatorSlash + dateTime.month.toString() + separatorSlash + dateTime.day.toString(); 
}

 Map<String, dynamic> getJsonArgumentSnackbar(bool isSuccess, String title, String message) => {
    "isSuccess": isSuccess,
    "title": title,
    "message": message
}; 