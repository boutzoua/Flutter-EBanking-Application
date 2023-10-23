import 'dart:convert';
import 'package:banking/constants/app_constants.dart';
import 'package:banking/screens/login/login_screen.dart';
import 'package:banking/screens/terms_conditon/terms_condition_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:banking/components/theme_helper.dart';
import 'package:banking/components/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:banking/components/banking_model.dart';
import 'package:nb_utils/nb_utils.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  BankingUserRegisterModel user = BankingUserRegisterModel(firstName: "",lastName:"" ,username: "",email: "",phoneNumber: "", dob:"", cin:"");
  // String url = "$hostLink/client/signup";

  bool checkedValue = false;
  bool checkboxValue = false;
  String dropdownValue = "Hssab 5000";

  Future<void> save() async {
    String url = "$hostLink/client/signup";
    var uri = Uri.parse(url);
    print(uri);
    var res = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username':user.username,
          'fullName':user.firstName,
          'lastName':user.lastName,
          'email': user.email,
          'phoneNumber':user.phoneNumber,
          'dob': user.dob,
          'cin':user.cin,
        }));
    print("${res.body}");
    if (res.statusCode >= 200 && res.statusCode < 300) {
      print("status==============================================="+ res.statusCode.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialog(),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150,false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10,0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    width: 5, color: Colors.white
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5,5),
                                    ),
                                  ]
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                            child: TextFormField(
                              decoration: ThemeHelper().textInputDecoration('First Name','Enter you first name..'),
                              onChanged: (val) {
                                user.firstName=val;
                              },
                              validator: (val){
                                if (val!.isEmpty) {
                                  return "Please enter your first name";
                                }
                                return null;
                              },
                            ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('Last Name','Enter you last name..'),
                            onChanged: (val) {
                              user.lastName = val;
                            },
                            validator: (val){
                              if (val!.isEmpty) {
                                return "Please enter your last name";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('UserName','Enter your username'),
                            onChanged: (val) {
                              user.username = val;
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
                        SizedBox(height: 20,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('E-mail Adress ','Enter you email..'),
                            onChanged: (val) {
                              user.email = val;
                            },
                            keyboardType: TextInputType.emailAddress,
                            validator: (val){
                              if((val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('Mobile Number','Enter your monile number...'),
                            onChanged: (val) {
                              user.phoneNumber = val;
                            },
                            keyboardType: TextInputType.phone,
                            validator: (val){
                              if((val!.isEmpty) && (RegExp(r"^(\d+)*$").hasMatch(val)) && (val.length<10)){
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('CIN','Enter your CIN...'),
                            onChanged: (val) {
                              user.cin = val;
                            },
                            validator: (val){
                              if (val!.isEmpty) {
                                return "Please enter your CIN";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('Day Of Birth','YYYY/DD/MM'),
                            onChanged: (val) {
                              user.dob = val;
                            },
                            validator: (val){
                              if (val!.isEmpty) {
                                return "Please enter your DOB";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          width: 120,
                          child: DropdownButton<String>(
                            menuMaxHeight: 150,
                            value: dropdownValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.grey),
                            underline: Container(
                              height:2,
                              color: Banking_Primary,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['Hssab 200', 'Hssab 5000', 'Hssab 20000']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(fontSize: 18 ),),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 5,),
                        FormField<bool>(
                            builder: (state){
                              return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value){
                                          setState(() {
                                            checkboxValue =value!;
                                            state.didChange(value);
                                          });
                                    }),
                                    Text("I accept all", style: TextStyle(color: Colors.grey),),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(2,8,5,8),
                                      //child: Text('Don\'t have an account? Create'),
                                      child: Text.rich(
                                          TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Terms and Conditions..',
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => TermsConditionPage()));
                                                    },
                                                  style: TextStyle(decoration:TextDecoration.underline,fontWeight: FontWeight.bold, color: kSecondaryColour, fontSize: 13),
                                                ),
                                              ]
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      state.errorText ?? '',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: Theme.of(context).errorColor,fontSize: 13,),
                                    ),
                                  )
                              ],
                              );
                            },
                          validator: (value){
                              if(!checkboxValue){
                                return 'You need to accept terms and conditions';
                              }else{
                                return null;
                              }
                          },
                          ),
                        SizedBox(height: 5.0,),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".toUpperCase(),
                                style: TextStyle(color: Colors.white, fontSize: 20.0,fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: (){
                              if(_formKey.currentState!.validate()){
                                save();
                                _formKey.currentState!.reset();
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10,10,10,10),
                          //child: Text('Don\'t have an account? Create'),
                          child: Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: "You have already an account? "),
                                    TextSpan(
                                      text: 'Login.',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: kSecondaryColour, fontSize: 15),
                                    ),
                                  ]
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomDialog extends StatelessWidget {
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
            Text("Your Registration Request is submitted successfully...",
              style: primaryTextStyle(size: 26,color: Colors.green),
              textAlign: TextAlign.justify,
            ),
            10.height,
            Text("Your request is being processed by our Agents.\n \nPlease wait until we inform you in your Number Phone.",
                style: primaryTextStyle(size: 18 )),
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
                Text("Login Page",
                    style: primaryTextStyle(size: 18, color: Banking_Primary))
                    .onTap(() {
                  finish(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                }).paddingLeft(16)
              ],
            ),
          ],
        ),
      ));
}
