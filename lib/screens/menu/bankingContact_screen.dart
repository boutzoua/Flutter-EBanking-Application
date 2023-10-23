import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:banking/constants/app_constants.dart';


class BankingContact extends StatefulWidget {
  static var tag = "/BankingContact";

  @override
  _BankingContactState createState() => _BankingContactState();
}

class _BankingContactState extends State<BankingContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Banking_app_Background,
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.chevron_left, size: 30, color: Banking_blackColor)
                      .onTap(
                        () {
                      finish(context);
                    },
                  ),
                  30.height,
                  Container(
                    padding: EdgeInsets.fromLTRB(20,30,30,30),
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topLeft,
                        colors: <Color>[Banking_Primary,Banking_palColor],
                      ),
                    ),
                    child: Text(Banking_lbl_Contact,
                        style: boldTextStyle(
                            size: 30, color: Banking_TextColorWhite)),
                  ),
                ],
              ),
              20.height,
              Container(
                decoration: boxDecorationWithShadow(
                    backgroundColor: Banking_whitePureColor,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Headquarters',
                        style:
                        primaryTextStyle(size: 18, fontFamily: fontMedium)),
                    20.height,
                    Row(
                      children: [
                        Image.asset("assets/images/Banking_ic_Pin.png",
                            height: 20, width: 20, color: Banking_Primary),
                        15.width,
                        Text("Sidi Maarouf - Casablanca",
                            style: primaryTextStyle(
                                color: Banking_TextColorSecondary,
                                size: 16,
                                fontFamily: fontRegular)),
                      ],
                    ),
                    15.height,
                    Row(
                      children: [
                        Image.asset("assets/images/Banking_ic_Call.png",
                            height: 20, width: 20, color: Banking_Primary),
                        15.width,
                        Text("+21244444444",
                            style: primaryTextStyle(
                                color: Banking_TextColorSecondary,
                                size: 16,
                                fontFamily: fontRegular)),
                      ],
                    ),
                    15.height,
                    Row(
                      children: [
                        Image.asset("assets/images/Banking_ic_Website.png",
                            height: 20, width: 20, color: Banking_Primary),
                        15.width,
                        Text("www.JabbekLah.com",
                            style: primaryTextStyle(
                                color: Banking_TextColorSecondary,
                                size: 16,
                                fontFamily: fontRegular)),
                      ],
                    ),
                    15.height,
                    Row(
                      children: [
                        Image.asset("assets/images/Banking_ic_Clock.png",
                            height: 20, width: 20, color: Banking_Primary),
                        15.width,
                        Text("08:00 - 17:00",
                            style: primaryTextStyle(
                                color: Banking_TextColorSecondary,
                                size: 16,
                                fontFamily: fontRegular)),
                      ],
                    ),
                  ],
                ),
              ),
              20.height,
              Container(
                decoration: boxDecorationWithShadow(
                    backgroundColor: Banking_whitePureColor,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Branch 1",
                        style:
                        primaryTextStyle(size: 18, fontFamily: fontMedium)),
                    20.height,
                    Row(
                      children: [
                        Image.asset("assets/images/Banking_ic_Pin.png",
                            height: 20, width: 20, color: Banking_Primary),
                        15.width,
                        Text("Gueliz -  Marrakech",
                            style: primaryTextStyle(
                                color: Banking_TextColorSecondary,
                                size: 16,
                                fontFamily: fontRegular)),
                      ],
                    ),
                    15.height,
                    Row(
                      children: [
                        Image.asset("assets/images/Banking_ic_Call.png",
                            height: 20, width: 20, color: Banking_Primary),
                        15.width,
                        Text("+212 5 20202020",
                            style: primaryTextStyle(
                                color: Banking_TextColorSecondary,
                                size: 16,
                                fontFamily: fontRegular)),
                      ],
                    ),
                    15.height,
                    Row(
                      children: [
                        Image.asset("assets/images/Banking_ic_Website.png",
                            height: 20, width: 20, color: Banking_Primary),
                        15.width,
                        Text("www.JabbekLah.com",
                            style: primaryTextStyle(
                                color: Banking_TextColorSecondary,
                                size: 16,
                                fontFamily: fontRegular)),
                      ],
                    ),
                    15.height,
                    Row(
                      children: [
                        Image.asset("assets/images/Banking_ic_Clock.png",
                            height: 20, width: 20, color: Banking_Primary),
                        15.width,
                        Text("08:00 - 17:00",
                            style: primaryTextStyle(
                                color: Banking_TextColorSecondary,
                                size: 16,
                                fontFamily: fontRegular)),
                      ],
                    ),
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