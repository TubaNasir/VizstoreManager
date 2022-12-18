import 'dart:ui';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        Center(
          child:  BackdropFilter(
            filter:  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Center(
              child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.black45)),
            ),
          ),
        );
  }
}
