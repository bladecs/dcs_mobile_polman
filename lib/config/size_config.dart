import 'package:flutter/material.dart';

class AppSizes{
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertikal;

  void initSizes(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    blockSizeHorizontal = screenWidth/100;
    blockSizeVertikal = screenHeight/100;
  }
}