import 'package:clean_app/constants/text_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

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