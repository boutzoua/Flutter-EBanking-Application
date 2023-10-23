import 'package:banking/components/banking_model.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:banking/components//theme_helper.dart';

import 'package:banking/screens/forget_password/otp_verification.dart';
import 'package:banking/screens/login/login_screen.dart';
import 'package:banking/components/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

import '../../components/changeNotifier.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String minToken;
  const ForgotPasswordPage({Key? key, required this.minToken}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late String minToken;
  late bool status;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordMatch = false;
  @override
  void initState() {
    super.initState();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    isPasswordMatch = false;
    minToken='';
    status=false;
  }





  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    double _headerHeight = 300;


    Future<void> changePassword(String newpass,String minToken) async {
      // Define the request URL
      String url = '$hostLink/auth/reset-password';

      // Define the request body
      Map<String, dynamic> requestBody = {
        'otp': newpass,
        'token': minToken,
      };

      // Define the authorization token

      // Send the POST request with authorization
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${user!.token}',
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: json.encode(requestBody),
      );
      print("response.boooooooody ${response.body}");
      if (response.statusCode >= 200 && response.statusCode < 210 ) {
        // Parse the response JSON
        print("response.boooooooody ${response.body}");
        status = true;

      } else {
        // Handle the request failure
        print('Failed to send OTP request. Status code: ${response.statusCode}');
      }

    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                child: HeaderWidget(_headerHeight, true, Icons.password_rounded),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Forgot Password?',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),
                              // textAlign: TextAlign.center,
                            ),
                            // SizedBox(height: 10,),
                            // Text('Enter the email address associated with your account.',
                            //   style: TextStyle(
                            //     // fontSize: 20,
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.black54
                            //   ),
                            //   // textAlign: TextAlign.center,
                            // ),
                            // SizedBox(height: 10,),
                            // Text('We will email you a verification code to check your authenticity.',
                            //   style: TextStyle(
                            //     color: Colors.black38,
                            //     // fontSize: 20,
                            //   ),
                            //   // textAlign: TextAlign.center,
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: [
                                  TextFormField(
                                    obscureText: true,
                                    controller: passwordController,
                                    decoration: ThemeHelper().textInputDecoration("New Password", "Enter your new password.."),
                                    validator: (val){
                                      if(val!.isEmpty){
                                        return "password can't be empty";
                                      }
                                      else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val)){
                                        return "Enter a strong password \n* At least 8 character \n* Contains at least one uppercase letter \n* Contains at least one lowercase letter \n* Contains at least one digit \n* Contains at least one special character";
                                      }
                                      return null;
                                    },
                                  ),
                                  12.height,
                                  TextFormField(
                                    obscureText: true,
                                    controller: confirmPasswordController,
                                    decoration: ThemeHelper().textInputDecoration("Confirm Password", "Confirm your New password"),
                                    validator: (val){
                                      if(val!.isEmpty){
                                        return "Email can't be empty";
                                      }else if(passwordController.text != confirmPasswordController.text){
                                        return "The password must be the same...";
                                      }
                                      return null;
                                    }
                                  ),
                                ],
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      40, 10, 40, 10),
                                  child: Text(
                                    "Reset".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if(_formKey.currentState!.validate()) {
                                      isPasswordMatch =
                                          passwordController.text ==
                                              confirmPasswordController.text;
                                    }
                                    if (isPasswordMatch){
                                      changePassword(passwordController as String, minToken);
                                      if( status){
                                      // enable.setIsEnabled=false;
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                      );
                                      }
                                    }
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Back to Login? "),
                                  TextSpan(
                                    text: 'Login',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => LoginPage()),
                                        );
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
