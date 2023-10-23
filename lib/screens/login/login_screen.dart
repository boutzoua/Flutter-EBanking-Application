import 'package:banking/components/banking_model.dart';
import 'package:banking/components/changeNotifier.dart';
import 'dart:convert';
import 'package:banking/screens/dashboard.dart';
import 'package:banking/screens/forget_password/otp_verification.dart';
import 'package:banking/screens/home/home_page_screen.dart';
import 'package:banking/screens/signup/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:banking/components/theme_helper.dart';
import 'package:banking/components/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:banking/screens/forget_password/forget_password_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget{
  static var tag = "/BankingSignIn";
  const LoginPage({Key? key}): super(key:key);
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();

  BankingUserLoginModel user = BankingUserLoginModel(username: "",password: "");

  Future<void> save() async {
    String url = "$hostLink/auth/login";
    var uri = Uri.parse(url);
    print(uri);
    var res = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username':user.username,
          'password':user.password
        }));
    print("${res.body}");
    if (res.statusCode >= 200 && res.statusCode < 300) {
      var jsonResponse = json.decode(res.body);
      var firstLogin = jsonResponse['firstLogin'];
      print(firstLogin);
      if (firstLogin) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialogFirstLogin(),
        );
      } else {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final responseBody = json.decode(res.body);

        final user = User(
          token: responseBody['token'],
          userType: responseBody['userType'],
          firstLogin: responseBody['firstLogin'],
          id: responseBody['id'],
          email: responseBody['email'],
          username: responseBody['username'],
          phoneNumber: responseBody['phoneNumber'],
          firstName: responseBody['firstName']??'',
          lastName: responseBody['lastName'],
          fullName: responseBody['fullName'],
        );
        print("----------------------------------- ${user.token}");

        userProvider.setUser(user);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BankingDashboard()),
        );
      }
    } else {
      // Handle error cases
      print('HTTP request failed with status: ${res.statusCode}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Inknown Usename or Password',style: TextStyle(fontSize:25,color: Colors.red ),),
            content: Text('You should to enter a valid Usename and Password',style: TextStyle(fontSize:15 ),),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  finish(context);
                },
              ),
            ],
          );
        },
      );
    }

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'Signin into your account',
                        style: TextStyle(fontSize:15 ,color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  decoration: ThemeHelper().textInputDecoration('Usename', 'Enter your user name'),
                                  onChanged: (val) {
                                    user.username=val;
                                  },
                                  validator: (val){
                                    if (val!.isEmpty) {
                                      return "Please enter your username";
                                    }
                                    return null;
                                  },
                                ),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
                                  onChanged: (val) {
                                    user.password=val;
                                  },
                                  validator: (val){
                                    if (val!.isEmpty) {
                                      return "Please enter your password";
                                    }
                                    return null;
                                  },
                                ),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10,0,10,20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push( context, MaterialPageRoute( builder: (context) => OTPVerificationPage()), );
                                  },
                                  child: Text( "Forgot your password?", style: TextStyle( fontSize: 15,color: Colors.blue, ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text('Sign In'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                  onPressed: (){
                                    if(_formKey.currentState!.validate()){
                                      //After successful login we will redirect to profile page. Let's create profile page now
                                      setState(() {
                                        save();
                                        _formKey.currentState!.reset();
                                      });
                                    }

                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10,20,10,20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: "Don\'t have an account? "),
                                          TextSpan(
                                            text: 'Create.',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                              },
                                            style: TextStyle(fontWeight: FontWeight.bold, color: kSecondaryColour, fontSize: 15),
                                          ),
                                        ]
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialogFirstLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

dialogContent(BuildContext context) {
  Future<void> _makeSocialMediaRequest(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
  return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("You should to verify your phoneNumber and change your Password in our web application...",
              style: primaryTextStyle(size: 26,color: Colors.red),
              textAlign: TextAlign.justify,
            ),
            10.height,
            Text("You want to visit our website? ",
                style: primaryTextStyle(size: 18,color: Colors.blue ),),
            10.height,
            Divider(height: 10, thickness: 1.0, color: Banking_greyColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Stay Here", style: primaryTextStyle(size: 18)).onTap(() {
                  finish(context);
                }).paddingRight(16),
                Container(width: 1.0, height: 40, color: Banking_greyColor)
                    .center(),
                Text("Visit Now",
                    style: primaryTextStyle(size: 18, color: Banking_Primary))
                    .onTap(() async {
                  finish(context);
                  _makeSocialMediaRequest("https://client-liart-psi.vercel.app/auth/login?returnUrl=%2F");
                }).paddingLeft(16)
              ],
            ),
          ],
        ),
      ));
}