import 'package:flutter/material.dart';
import 'package:short_links/ui/resources/color_manager.dart';


final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorManager.lightPrimary,
    fontFamily: "Roboto",

    scaffoldBackgroundColor: Colors.white,


    cardColor: Colors.white,

    colorScheme: ColorScheme.light(
      primary: ColorManager.lightPrimary,
      onPrimary: Colors.white,
      secondary: ColorManager.lightSecondary,
      onSecondary: Colors.white,
    ),

    appBarTheme: AppBarTheme(
        elevation: 2,
        color: Colors.white,
        centerTitle: true,
        foregroundColor: ColorManager.primaryColor,
        toolbarTextStyle: const TextStyle(fontSize: 18),
        iconTheme: IconThemeData(
            color: ColorManager.primaryColor
        )
    ),
    tabBarTheme: const TabBarTheme(),



    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorManager.primaryColor,
      selectionColor: ColorManager.primaryColor,
      selectionHandleColor: ColorManager.primaryColor,
    ),



    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorManager.inputBackground,
      filled: true,
      suffixIconColor: ColorManager.primaryColor,
      hintStyle: const TextStyle(fontWeight: FontWeight.w500),

      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
              color: Colors.white
          )
      ),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
              color: Colors.white
          )
      ),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
              color: Colors.white
          )
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
              color: ColorManager.primaryColor
          )
      ),

    )





);



