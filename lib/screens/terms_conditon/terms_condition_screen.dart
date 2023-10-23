import 'package:banking/screens/signup/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:banking/components/theme_helper.dart';
import 'package:banking/components/widgets.dart';

class TermsConditionPage extends StatelessWidget{
  double _headerHeight = 150;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, false, Icons.info_outline_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 5, 20, 10),// This will be the login form
                  child: Column(
                    children: [
                      Text(
                        """Terms and Conditons of Use""",
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        """By accessing and using our e-banking application, you agree to the following terms and conditions:""",
                        style: TextStyle(fontSize:20 ,color: Colors.grey, ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        """1- Registration: You must register for an account with our e-banking application in order to use it. You are responsible for providing accurate and complete information during registration. You are also responsible for maintaining the confidentiality of your account login information.

2- Use of the Application: You are responsible for all activity that occurs under your account. You agree to use the e-banking application only for lawful purposes and in a way that does not infringe the rights of others or restrict or inhibit anyone else's use of the application.

3- Security: You are responsible for taking all necessary precautions to ensure that your use of the e-banking application is secure and free from viruses, worms, Trojan horses, or other malware that may damage or disrupt the operation of your computer or network.

4- Privacy: We respect your privacy and are committed to protecting your personal information. Our Privacy Policy outlines the types of information we collect, how we use it, and how we protect it.

5- Intellectual Property: All content on the e-banking application, including text, graphics, logos, images, and software, is the property of our company or its licensors and is protected by copyright, trademark, and other intellectual property laws.

6- Limitation of Liability: We are not liable for any damages, including direct, indirect, incidental, special, consequential, or punitive damages arising out of your use of the e-banking application or your inability to access or use the application.

7- Governing Law: These terms and conditions are governed by and construed in accordance with the laws of the jurisdiction where our company is located. Any disputes arising under these terms and conditions will be resolved in accordance with the laws of that jurisdiction.

8- Amendments: We reserve the right to amend these terms and conditions at any time and without notice. Your continued use of the e-banking application after any such amendments will constitute your acceptance of the amended terms and conditions.""",
                        style: TextStyle(fontSize:15 ,color: Colors.grey, ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 15,),
                      Text(
                        """If you do not agree to these terms and conditions, you should not use the e-banking application.""",
                        style: TextStyle(fontSize:20 ,color: Colors.red, ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20,),
                      Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_back_ios, color: Colors.white),
                                  Text('Go Back...'.toUpperCase(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          onPressed: (){
                            //After successful login we will redirect to profile page. Let's create profile page now
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                            Navigator.pop(context);
                          },
                        ),
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