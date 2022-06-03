import 'package:flutter/material.dart';

Color mainColor = Color(0xff6e4c8f);
Color canvasColor = Color(0xff1e1b21);
const Color canvasColor1 = Color(0xff1e1b21);
const Color textColor = Color.fromRGBO(252, 241, 206, 1.0);
const Color primaryColor = Color.fromRGBO(250, 240, 206, 1.0);
Color card = Color(0xff32243a);
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
