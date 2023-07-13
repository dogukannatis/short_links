
import 'package:flutter/material.dart';

class ColorManager {
  static Color lightPrimary = const Color(0xFF2a86ff);
  static Color lightSecondary = const Color(0xFFFFA32A);
  static Color inputBackground = const Color(0xFFf1f4f5);
  static Color backgroundAlternateColor = const Color(0xFFF7F6F2);

  static Color grey1 =HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");

  static const _primaryColor = 0xFF1a434d;

  static MaterialColor primaryColor = const MaterialColor(
    _primaryColor,
    <int, Color>{
      50: Color(0xFF338599),
      100: Color(0xFF2E778A),
      200: Color(0xFF296A7A),
      300: Color(0xFF245D6B),
      400: Color(0xFF1F505C),
      500: Color(_primaryColor),
      600: Color(0xFF14353D),
      700: Color(0xFF0F282E),
      800: Color(0xFF0A1B1F),
      900: Color(0xFF050D0F),
    },
  );

}

extension HexColor on Color {
  static Color fromHex(String hexColorString){
    hexColorString = hexColorString.replaceAll("#", "");
    if(hexColorString.length == 6){
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}