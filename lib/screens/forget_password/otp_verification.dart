import 'package:banking/components/banking_model.dart';
import 'package:banking/components/changeNotifier.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:banking/screens/dashboard.dart';
import 'package:banking/screens/forget_password/forget_password_screen.dart';
import 'package:banking/screens/payment/bankingPayment_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:banking/components/theme_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:banking/screens/home/home_page_screen.dart';
import 'package:banking/components/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({Key? key}) : super(key: key);

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _pinSuccess = false;
  late String _enteredOTP;
  late String minToken;
  late bool status;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
    _enteredOTP = '';
    minToken='';
    status=false;
  }


  late FToast fToast;


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    double _headerHeight = 300;


    Future<void> sendOTPRequest(String token) async {
      // Define the request URL
      String url = '$hostLink/auth/get-otp';

      // Define the request body
      Map<String, dynamic> requestBody = {
      };

      // Send the POST request
      var response = await http.post(Uri.parse(url),
          headers: { 'Authorization': 'Bearer $token',
          },
          body: requestBody);
      // Check the response status code
      if (response.statusCode >= 200 && response.statusCode < 210 ) {
        // Parse the response JSON
        print("response.boooooooody ${response.body}");
        minToken = response.body;

      } else {
        // Handle the request failure
        print('Failed to send OTP request. Status code: ${response.statusCode}');
      }
    }

    Future<void> verifyOTP(String otp,String minToken) async {
      // Define the request URL
      String url = '$hostLink/auth/verify-otp';

      // Define the request body
      Map<String, dynamic> requestBody = {
        'otp': otp,
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
                child: HeaderWidget(
                    _headerHeight, true, Icons.privacy_tip_outlined),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
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
                            Text('Verification',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'Enter the verification code we just sent you on your phone number address.',
                              style: TextStyle(
                                // fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            OTPTextField(
                              length: 4,
                              width: 300,
                              fieldWidth: 50,
                              style: TextStyle(
                                  fontSize: 30
                              ),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.underline,
                              onCompleted: (pin) {
                                setState(() {
                                  _pinSuccess = true;
                                  _enteredOTP = pin;
                                  print("entereeeeeeeed oyp $_enteredOTP");
                                });
                              },

                            ),
                            SizedBox(height: 50.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "If you didn't receive a code! ",
                                    style: TextStyle(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'get OTP',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        sendOTPRequest(user!.token);
                                        print("minToken ==================${user!.token}");
                                        print("minToken ==================$minToken");
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog("Successful",
                                                "Verification code resend successful.",
                                                context);
                                          },
                                        );

                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Row(
                              children: [
                                Container(
                                  decoration: _pinSuccess ? ThemeHelper().buttonBoxDecoration(context):ThemeHelper().buttonBoxDecoration(context, "#AAAAAA","#757575"),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 10, 30, 10),
                                      child: Text(
                                        "Verify".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onPressed: _pinSuccess ? () {
                                      print("otp etred ========$_enteredOTP");
                                      print("min token ========$minToken");

                                      verifyOTP(_enteredOTP!, minToken);
                                      if (status) {
                                        Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (context) => BankingDashboard()),
                                              (Route<dynamic> route) => false,
                                        );

                                      }

                                    } : null,
                                  ),
                                ),
                                15.width,
                                Container(
                                  decoration: ThemeHelper().buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 15, 10),
                                      child: Text(
                                        "Cancel".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => ForgotPasswordPage(minToken: minToken,)
                                          ),
                                              (Route<dynamic> route) => false
                                      );
                                    },
                                  ),
                                ),
                              ],
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

//   _showToast(String name, Color color) {
//     Widget toast = Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25.0),
//         color: color,
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(Icons.check),
//           SizedBox(
//             width: 12.0,
//           ),
//           Text(name,style: TextStyle(fontSize: 10),),
//         ],
//       ),
//     );
//
//
//     fToast.showToast(
//       child: toast,
//       gravity: ToastGravity.BOTTOM,
//       toastDuration: Duration(seconds: 3),
//     );
//
//     // Custom Toast Position
//     fToast.showToast(
//         child: toast,
//         toastDuration: Duration(seconds: 3),
//         positionedToastBuilder: (context, child) {
//           return Positioned(
//             child: child,
//             top: 16.0,
//             left: 16.0,
//           );
//         });
//   }
//
}

