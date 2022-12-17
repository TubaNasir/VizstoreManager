import 'package:flutter/material.dart';

class MainPageInfo extends StatelessWidget {
  const MainPageInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "VIZSTORE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Manage your store easily with Vizstore Manager",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
