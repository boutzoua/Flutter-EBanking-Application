import 'package:banking/components/changeNotifier.dart';
import 'package:banking/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:banking/components/widgets.dart';
import 'package:provider/provider.dart';

import 'bankingChangePassword.dart';
import 'bankingContact_screen.dart';
import 'bankingNews_screen.dart';
import 'bankingQA_screen.dart';
import 'bankingShareInformation_screen.dart';
import 'termsandcondition_screen.dart';
import 'package:banking/screens/terms_conditon/terms_condition_screen.dart';

class BankingMenu extends StatefulWidget {
  static var tag = "/BankingMenu";


  @override
  _BankingMenuState createState() => _BankingMenuState();
}

class _BankingMenuState extends State<BankingMenu> {


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      backgroundColor: Banking_app_Background,
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              10.height,
              Text(Banking_lbl_Menu,
                  style:
                  boldTextStyle(color: Banking_TextColorPrimary, size: 35)),
              16.height,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topLeft,
                    colors: <Color>[Banking_Primary,Banking_palColor],
                  ),
                ),
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage: AssetImage("assets/images/1mustapha-boutzoua1.jpg"),
                        radius: 40),
                    10.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        5.height,
                        Text(user!.username.toString(),
                            style: boldTextStyle(
                                color: Banking_app_Background, size: 20)),
                        5.height,
                        Text(user!.phoneNumber.toString(),
                            style: primaryTextStyle(
                                color: Banking_bottomEditTextLineColor,
                                size: 16,
                                fontFamily: fontMedium)),
                        5.height,
                        Text("Jabbek Lah",
                            style: primaryTextStyle(
                                color: Banking_bottomEditTextLineColor,
                                size: 16,
                                fontFamily: fontMedium)),
                      ],
                    ).expand()
                  ],
                ),
              ),
              16.height,
              Container(
                padding: EdgeInsets.all(8),
                decoration: boxDecorationWithShadow(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: <Widget>[
                    // bankingOption("assets/images/Banking_ic_Setting.png", Banking_lbl_Setting,
                    //     Banking_blueColor),
                    bankingOption("assets/images/Banking_ic_security.png",
                        Banking_lbl_Change_Password, Banking_Primary)
                        .onTap(() {
                      BankingChangePassword().launch(context);
                    }),
                    bankingOption(
                        "assets/images/Banking_ic_Share.png",
                        Banking_lbl_Share_Information_account,
                        Banking_Primary)
                        .onTap(() {
                      BankingShareInformation().launch(context);
                    }),
                  ],
                ),
              ),
              16.height,
              Container(
                padding: EdgeInsets.all(8),
                decoration: boxDecorationWithShadow(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: spacing_middle,
                    ),
                    bankingOption("assets/images/Banking_ic_TC.png", Banking_lbl_Term_Conditions,
                        Banking_Primary)
                        .onTap(() {
                      BankingTermsCondition().launch(context);
                    }),
                    bankingOption("assets/images/Banking_ic_Question.png",
                        Banking_lbl_Questions_Answers, Banking_Primary)
                        .onTap(() {
                      BankingQuestionAnswer().launch(context);
                    }),
                    bankingOption("assets/images/Banking_ic_Call.png", Banking_lbl_Contact,
                        Banking_Primary)
                        .onTap(() {
                      BankingContact().launch(context);
                    }),
                    SizedBox(
                      height: spacing_middle,
                    ),
                  ],
                ),
              ),
              16.height,
              Container(
                padding: EdgeInsets.all(8),
                decoration: boxDecorationWithShadow(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: <Widget>[
                    bankingOption("assets/images/Banking_ic_Logout.png", Banking_lbl_Logout,
                        Banking_Primary)
                        .onTap(() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          16.height,
          Text(Banking_lbl_Confirmation_for_logout,
              style: primaryTextStyle(size: 18))
              .onTap(() {
            finish(context);
          }).paddingOnly(top: 8, bottom: 8),
          Divider(height: 10, thickness: 1.0, color: Banking_greyColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Cancel", style: primaryTextStyle(size: 18)).onTap(() {
                finish(context);
              }).paddingRight(16),
              Container(width: 1.0, height: 40, color: Banking_greyColor)
                  .center(),
              Text("Logout",
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
          16.height,
        ],
      ));
}