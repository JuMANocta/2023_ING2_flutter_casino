import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

final ThemeData casinoTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF2C2C2E),
    secondary: Color(0xFFD4AF37),
    surface: Color(0xFF1C1C1E),
    background: Color(0xFF1C1C1E),
    error: Color(0xFFD22F2E),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.montserratTextTheme()
      .apply(bodyColor: Colors.black, displayColor: Colors.white),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFFD22F2E),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey[700]),
    labelStyle: const TextStyle(color: Colors.black),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      // borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      // borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF2C2C2E),
    titleTextStyle: TextStyle(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF2C2C2E),
    selectedItemColor: Color(0xFFD4AF37),
    unselectedItemColor: Colors.grey,
  ),
);
