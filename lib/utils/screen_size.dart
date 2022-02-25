import 'package:flutter/material.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context) {
  return screenSize(context).height;
}

double screenWidth(BuildContext context) {
  return screenSize(context).width;
}

double textSize(BuildContext context) {
  return MediaQuery.textScaleFactorOf(context);
}
