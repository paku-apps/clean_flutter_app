import 'package:clean_app/constants/text_constants.dart';
import 'package:url_launcher/url_launcher.dart';

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