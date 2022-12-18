import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:vizstore_manager/constants.dart';
import 'package:vizstore_manager/controllers/login_provider.dart';
import 'package:vizstore_manager/product/product_list.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    bool passwordVisible = context.watch<LoginProvider>().passwordVisible;
    bool isLoading = context.watch<LoginProvider>().isLoading;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Container(
              height: 450,
              width: 350,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LOG IN",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 30,
                          child: Divider(
                            color: SecondaryColor,
                            thickness: 2,
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              labelText: 'Email',
                              suffixIcon: Icon(
                                Icons.mail_outline,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            controller: _emailController),
                        SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  context
                                      .read<LoginProvider>()
                                      .changePasswordVisible();
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            obscureText: !passwordVisible,
                            controller: _passwordController),
                        isLoading
                            ? SizedBox(
                                height: 64,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : SizedBox(
                                height: 64,
                              ),
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              Future<bool> success = context
                                  .read<LoginProvider>()
                                  .signIn(_emailController.text,
                                      _passwordController.text);
                              if (await success == true) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProductList(),
                                  ),
                                );
                              }
                            }
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: PrimaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: PrimaryColor.withOpacity(0.2),
                                  spreadRadius: 4,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
