import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/constants.dart';
import 'package:vizstore_manager/controllers/login_provider.dart';
import 'package:vizstore_manager/login/widgets/login_form.dart';
import 'package:vizstore_manager/login/widgets/main_page_info.dart';
import 'package:vizstore_manager/login/widgets/welcome_message.dart';
import 'package:vizstore_manager/widgets/loader.dart';

class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    bool isLoading = context.watch<LoginProvider>().isLoading;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: double.infinity,
                  width: size.width * 0.5,
                  color: Colors.black87,
                ),
                Container(
                    height: double.infinity,
                    width: size.width * 0.5,
                    color: SecondaryColor
                ),
              ],
            ),

            WelcomeMessage(),

            MainPageInfo(),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Icon(
                      Icons.copyright,
                      color: Colors.grey,
                      size: 24,
                    ),

                    SizedBox(
                      width: 8,
                    ),

                    Text(
                      "Copyright 2022",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Stack(
              children: [
                LoginForm(),
                if(isLoading)
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.5,
                      left: MediaQuery.of(context).size.width * 0.5,
                      child: Loader()
                  )
              ],
            ),

          ],
        ),
      ),
    );

  }
}


