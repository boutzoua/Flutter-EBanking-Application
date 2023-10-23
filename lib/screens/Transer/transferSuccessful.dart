import 'package:banking/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:banking/components/widgets.dart';
import 'package:banking/constants/app_constants.dart';

class BankingTransferSuccessful extends StatefulWidget {
  static var tag = "/BankingTransferSuccessful";

  @override
  _BankingTransferSuccessfulState createState() =>
      _BankingTransferSuccessfulState();
}

class _BankingTransferSuccessfulState extends State<BankingTransferSuccessful> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Banking_whitePureColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            8.height,
            Container(
                child: headerView(Banking_lbl_Transfer_Successful, width * 0.4, context)),
            24.height,
            Image.asset("assets/images/Banking_ic_walk2.jpg",
                height: width * 0.6, width: width, fit: BoxFit.cover),
            24.height,
            Text(Banking_lbl_Info_Transfer_Successful,
                style: secondaryTextStyle(
                    color: Banking_TextColorSecondary, size: 18),
                textAlign: TextAlign.center)
                .center(),
            30.height,
            Container(
              margin:EdgeInsets.only(right: 47,left: 47) ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topLeft,
                  colors: <Color>[Banking_Primary,Banking_palColor],
                ),
              ),
              child: BankingButton(
                  textContent: Banking_lbl_Transaction_History,
                  onPressed: () {
                    finish(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BankingDashboard(),
                      ),
                    );
                  })

            ),
          ],
        ),
      ),
    );
  }
}