import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alamanaelrasyl/core/resources/app_color.dart';

ThemeData get applicationTheme => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldColor,

      /// Main Color

      primaryColor: const Color(0xFF26A247),
      primaryColorLight: const Color(0xFF49A226),
      primaryColorDark: Colors.black,
      disabledColor: Colors.grey,

      /// CardViewTheme

      cardTheme: const CardTheme(),

      /// AppBar Theme

      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: AppColors.mainApp,
          ),
          backgroundColor: AppColors.mainApp,
          titleTextStyle: TextStyle(
              fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white)),

      /// Button Theme

      buttonTheme: const ButtonThemeData(),

      /// Elevated Button Theme

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              backgroundColor: AppColors.mainApp)),

      /// Text Theme

      textTheme: const TextTheme(
        //
        headlineLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),

        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        labelLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        labelMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),

      /// Input Decoration Theme (text form filed)
    );
