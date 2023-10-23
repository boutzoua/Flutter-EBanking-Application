import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:banking/components/widgets.dart';
import 'package:banking/constants/app_constants.dart';

class BankingChangePassword extends StatefulWidget {
  static var tag = "/BankingChangePassword";

  @override
  _BankingChangePasswordState createState() => _BankingChangePasswordState();
}

class _BankingChangePasswordState extends State<BankingChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Banking_app_Background,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.height,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.chevron_left,
                          size: 25, color: Banking_blackColor)
                          .onTap(
                            () {
                          finish(context);
                        },
                      ),
                      20.height,
                      Container(
                        padding: EdgeInsets.all(13),
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topLeft,
                            colors: <Color>[Banking_Primary,Banking_palColor],
                          ),
                        ),
                        child: Text("Change\nPassword",
                            style: boldTextStyle(
                                size: 30, color: Banking_TextColorWhite)),
                      ),
                    ],
                  ),
                  20.height,
                  EditText(
                      text: "Old Password", isPassword: true, isSecure: true),
                  16.height,
                  EditText(
                      text: "New Password", isPassword: true, isSecure: true),
                  16.height,
                  40.height,
                  Container(
                    margin:EdgeInsets.only(right: 80,left: 80) ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topLeft,
                        colors: <Color>[Banking_Primary,Banking_palColor],
                      ),
                    ),
                    child: BankingButton(
                        textContent: Banking_lbl_Confirm,
                        onPressed: () {
                          toasty(context, 'Password Successfully Changed');
                          finish(context);
                        }),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              Banking_lbl_app_Name.toUpperCase(),
              style: primaryTextStyle(
                  color: Banking_TextColorSecondary,
                  size: 18,
                  fontFamily: fontRegular),
            ),
          ).paddingBottom(16),
        ],
      ),
    );
  }
}