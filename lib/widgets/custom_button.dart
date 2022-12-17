import 'package:flutter/material.dart';
import 'package:vizstore_manager/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.pressed,
  }) : super(key: key);
  final String text;
  final VoidCallback pressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: MediaQuery.of(context).size.width,
      height: 30,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        onPressed: pressed,
        child: Ink(
          decoration: const BoxDecoration(
            color: Colors.white,
            gradient: PrimaryGradientColor,
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:12.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: TextColor1, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
