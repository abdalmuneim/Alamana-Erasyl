import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alamanaelrasyl/core/resources/app_color.dart';
import 'package:sizer/sizer.dart';

ThemeData get applicationTheme => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldColor,

      /// Main Color

      primaryColor: const Color(0xFF26A247),
      primaryColorLight: const Color(0xFF49A226),
      primaryColorDark: Colors.black,
      disabledColor: Colors.grey,
      fontFamily: GoogleFonts.cairo().fontFamily,

      /// CardViewTheme
      cardTheme: const CardTheme(),

      /// AppBar Theme
      appBarTheme: AppBarTheme(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: AppColors.mainApp,
          ),
          backgroundColor: AppColors.mainApp,
          titleTextStyle: GoogleFonts.cairo(
              fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white)),

      /// Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle:
              WidgetStateProperty.resolveWith((Set<MaterialState> states) {
            return GoogleFonts.cairo(
              fontSize: 10.sp, // Set your desired font size
              fontWeight: FontWeight.normal, // Set your desired font weight
            );
          }),
        ),
      ),
      buttonTheme: const ButtonThemeData(),

      /// Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              backgroundColor: AppColors.mainApp)),

      /// Text Theme
      textTheme: TextTheme(
        //
        headlineLarge: GoogleFonts.cairo(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        headlineSmall: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        labelLarge: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        labelMedium: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),

        titleLarge: GoogleFonts.cairo(
          fontSize: 14.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.cairo(
          fontSize: 12.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: GoogleFonts.cairo(
          fontSize: 10.sp,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.cairo(
          fontSize: 10.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: GoogleFonts.cairo(
          fontSize: 10.sp,
          color: Colors.black,
        ),
        bodySmall: GoogleFonts.cairo(
          fontSize: 8.sp,
          color: Colors.grey,
        ),
      ),

      /// Input Decoration Theme (text form filed)
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        hintStyle: GoogleFonts.cairo(
          color: Colors.grey.withOpacity(.8),
        ),
        errorStyle: GoogleFonts.cairo(
          color: AppColors.red,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        suffixIconColor: Colors.black,
        prefixIconColor: Colors.black,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black38,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black38,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.red,
            width: .2,
          ),
        ),
      ),
    );
