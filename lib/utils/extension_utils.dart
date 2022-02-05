import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

extension extensionBooleans on bool {

  bool toogle() {
    return !this;
  }

}


double getResponsiveWidthContainer(MediaQueryData mediaQueryData){
  if(mediaQueryData.size.width>950){
    //Desktop
    return 700;
  } else if(mediaQueryData.size.width>600){
    //Tablet
    return 500;
  } else {
    //Size Mobile
    return 350;
  }
}

double getResponsiveWidthContainerCheckbox(MediaQueryData mediaQueryData){
  if(mediaQueryData.size.width>950){
    //Desktop
    return 570;
  } else if(mediaQueryData.size.width>600){
    //Tablet
    return 370;
  } else {
    //Size Mobile
    return 220;
  }
}

bool isMobile(){
  return GetPlatform.isMobile;
}