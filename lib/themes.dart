import 'package:google_fonts/google_fonts.dart';
import 'package:vizstore_manager/constants.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      colorScheme: ThemeData().colorScheme.copyWith(primary: PrimaryColor),
      scaffoldBackgroundColor: Colors.white,
      //appBarTheme: appBarTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      textTheme: GoogleFonts.nunitoSansTextTheme());
}


/*AppBarTheme appBarTheme() {
  return AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: const TextTheme(
      headline6: TextStyle(color: TextColor, fontSize: 18),
    ).headline6,

  );
}*/

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: TextColor2),
    gapPadding: 10,
  );

  return InputDecorationTheme(
    //floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 12),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}