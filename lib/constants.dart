import 'package:flutter/material.dart';

const PrimaryColor = Color.fromARGB(255, 248, 185, 13);
const PrimaryLightColor = Color(0xFFF4FAA1);
const PrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color.fromARGB(255, 248, 185, 13),Color.fromARGB(255, 252, 217, 28)],
);
const SecondaryColor = Color(0xFFECE7E7);
const TextColor1 = Colors.black;
const TextColor2 = Color(0xFF8C8A8A);

final categories = ['Toys', 'Lifestyle', 'Clothes', 'Shoes', 'Furniture'];

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: 10),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: TextColor2),
  );
}