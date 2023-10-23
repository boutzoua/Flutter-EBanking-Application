import 'package:banking/components/BankingSlider.dart';
import 'package:banking/screens/Transer/transferSuccessful.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'BankingTransferSuccessful.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:banking/components/widgets.dart';


class BankingTransfer extends StatefulWidget {
  static var tag = "/BankingTransfer";

  @override
  _BankingTransferState createState() => _BankingTransferState();
}

class _BankingTransferState extends State<BankingTransfer> {
  bool isSwitch = false;
  bool isGetOtp = false;
  var tapCount = 0;

  void tappedConfirm() {
    if (tapCount != 1) {
      BankingTransferSuccessful().launch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Banking_app_Background,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.height,
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Banking_Primary,Banking_palColor],
                ),),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          isSwitch == true
                              ? Banking_lbl_Confirm_Transfer
                              : Banking_lbl_Transfer,
                          style: primaryTextStyle(
                              color: Banking_app_Background,
                              size: 35,
                              fontFamily: fontBold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text("Choose Account to Transfer",
                            style: primaryTextStyle(
                                color: Banking_bottomEditTextLineColor,
                                size: 14,
                                fontFamily: fontBold)),
                      ),
                      16.height,
                      BankingSliderWidget().visible(isSwitch == false),
                      Container(
                        margin: EdgeInsets.only(
                            left: spacing_standard_new, right: spacing_standard_new),
                        child: Stack(
                          children: [
                            Image.asset("assets/images/banking_card_bg.jpg",
                                fit: BoxFit.cover, height: 220),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Reda Himmi",
                                        style: boldTextStyle(
                                            color: Banking_whitePureColor,
                                            size: 18,
                                            fontFamily: fontMedium))
                                        .paddingOnly(
                                        top: spacing_large,
                                        left: spacing_standard_new),

                                    Text(Banking_lbl_app_Name,
                                        style: boldTextStyle(
                                            color: Banking_whitePureColor,
                                            size: 16,
                                            fontFamily: fontMedium))
                                        .paddingOnly(
                                        top: spacing_large,
                                        right: spacing_standard_new)
                                  ],
                                ),
                                50.height,
                                Text("The Same Bank",
                                    style: boldTextStyle(
                                        color: Banking_whitePureColor,
                                        size: 18,
                                        fontFamily: fontMedium))
                                    .paddingOnly(
                                    top: spacing_large, left: spacing_standard_new),
                                Text('1121 *** ** *** 5555',
                                    style: boldTextStyle(
                                        color: Banking_whitePureColor,
                                        size: 18,
                                        fontFamily: fontMedium))
                                    .paddingOnly(
                                    left: spacing_standard_new,
                                    top: spacing_control),
                                Text("\$" + "12,500",
                                    style: boldTextStyle(
                                        color: Banking_whitePureColor,
                                        size: 18,
                                        fontFamily: fontMedium))
                                    .paddingOnly(
                                    top: spacing_standard,
                                    left: spacing_standard_new),
                              ],
                            ),
                            10.height,
                          ],
                        ),
                      ).visible(isSwitch == true),
                      15.height,
                    ],
                  ),
                ),
              ),
              16.height,
              Divider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: boxDecorationRoundedWithShadow(8,
                          backgroundColor: Banking_whitePureColor,
                          spreadRadius: 0,
                          blurRadius: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose Bank Name",
                              style: primaryTextStyle(
                                  color: Banking_TextColorSecondary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                          Row(
                            children: [
                              Text("The Same Bank",
                                  style: primaryTextStyle(
                                      color: Banking_TextColorPrimary,
                                      size: 16,
                                      fontFamily: fontRegular)),
                              Icon(Icons.keyboard_arrow_right,
                                  size: 30, color: Banking_greyColor),
                            ],
                          ).onTap(
                                () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => CustomDialog(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: boxDecorationRoundedWithShadow(8,
                          backgroundColor: Banking_whitePureColor,
                          spreadRadius: 0,
                          blurRadius: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose Beneficiery",
                              style: primaryTextStyle(
                                  color: Banking_TextColorSecondary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                          Row(
                            children: [
                              Text("Mustapha BTZ",
                                  style: primaryTextStyle(
                                      color: Banking_TextColorPrimary,
                                      size: 16,
                                      fontFamily: fontRegular)),
                              Icon(Icons.keyboard_arrow_right,
                                  size: 30, color: Banking_greyColor),
                            ],
                          ).onTap(
                                () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => CustomDialogBF(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: boxDecorationRoundedWithShadow(8,
                          backgroundColor: Banking_whitePureColor,
                          spreadRadius: 0,
                          blurRadius: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Account Number",
                              style: primaryTextStyle(
                                  color: Banking_TextColorSecondary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                          Text("123 456 789",
                              style: primaryTextStyle(
                                  color: Banking_TextColorPrimary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                        ],
                      ),
                    ),
                    Divider(height: 10),
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: boxDecorationRoundedWithShadow(8,
                          backgroundColor: Banking_whitePureColor,
                          spreadRadius: 0,
                          blurRadius: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Bank",
                              style: primaryTextStyle(
                                  color: Banking_TextColorSecondary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                          Text(Banking_lbl_app_Name,
                              style: primaryTextStyle(
                                  color: Banking_TextColorPrimary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                        ],
                      ),
                    ),
                    Divider(height: 4),
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: boxDecorationRoundedWithShadow(8,
                          backgroundColor: Banking_whitePureColor,
                          spreadRadius: 0,
                          blurRadius: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Branch",
                              style: primaryTextStyle(
                                  color: Banking_TextColorSecondary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                          Text("Marrakech",
                              style: primaryTextStyle(
                                  color: Banking_TextColorPrimary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                        ],
                      ),
                    ),
                    Divider(height: 10),
                    Text("Transfer Info",
                        style: primaryTextStyle(
                            color: Banking_TextColorSecondary,
                            size: 20,
                            fontFamily: fontRegular)),
                    10.height,
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: boxDecorationRoundedWithShadow(8,
                          backgroundColor: Banking_whitePureColor,
                          spreadRadius: 0,
                          blurRadius: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Amount",
                              style: primaryTextStyle(
                                  color: Banking_TextColorSecondary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                          Text("\$1000",
                              style: primaryTextStyle(
                                  color: Banking_TextColorPrimary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                        ],
                      ),
                    ),
                    Divider(height: 24),
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: boxDecorationRoundedWithShadow(8,
                          backgroundColor: Banking_whitePureColor,
                          spreadRadius: 0,
                          blurRadius: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Message",
                              style: primaryTextStyle(
                                  color: Banking_TextColorSecondary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                          Text("Rental Car Fee",
                              style: primaryTextStyle(
                                  color: Banking_TextColorPrimary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                        ],
                      ),
                    ),
                    Divider(height: 4),
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: boxDecorationRoundedWithShadow(8,
                          backgroundColor: Banking_whitePureColor,
                          spreadRadius: 0,
                          blurRadius: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Fee Transaction",
                              style: primaryTextStyle(
                                  color: Banking_TextColorSecondary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                          Text("\$10",
                              style: primaryTextStyle(
                                  color: Banking_TextColorPrimary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                        ],
                      ),
                    ),
                    Divider(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("A OTP code has been send to your phone",
                            style: primaryTextStyle(
                                color: Banking_TextColorSecondary,
                                size: 14,
                                fontFamily: fontRegular)),
                        5.height,
                        EditText(text: "Enter OTP", isPassword: false),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(Banking_lbl_Resend,
                              style: primaryTextStyle(color: Colors.blue,
                                  size: 18, fontFamily: fontRegular))
                              .onTap(() {}),
                        ),
                      ],
                    ).visible(isGetOtp == true),
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: boxDecorationRoundedWithShadow(8,
                          backgroundColor: Banking_whitePureColor,
                          spreadRadius: 0,
                          blurRadius: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Save this Beneficiary",
                              style: primaryTextStyle(
                                  color: Banking_TextColorSecondary,
                                  size: 16,
                                  fontFamily: fontRegular)),
                          Switch(
                            value: isSwitch,
                            onChanged: (value) {
                              setState(() {
                                isSwitch = value;
                                print(isSwitch);
                              });
                            },
                            activeTrackColor: Banking_Primary.withOpacity(0.5),
                            activeColor: Banking_Primary,
                          ),
                        ],
                      ).visible(isGetOtp == false),
                    ),
                    Divider(height: 10),
                    Center(
                      child: Container(
                        margin:EdgeInsets.only(right: 90,left: 90) ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topLeft,
                            colors: <Color>[Banking_Primary,Banking_palColor],
                          ),
                        ),
                        child: BankingButton(
                            textContent: isGetOtp == true
                                ? Banking_lbl_Confirm
                                : Banking_lbl_Get_OTP,
                            onPressed: () {
                              setState(
                                    () {
                                  isGetOtp = true;
                                  tapCount = tapCount + 1;
                                  tappedConfirm();
                                },
                              );
                            }).visible(isSwitch == true),
                      ),
                    ),
                    24.height,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

dialogContent(BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
    decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(10),
        backgroundColor: Banking_whitePureColor),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        8.height,
        Text(Banking_lbl_Same_Bank,
            style: primaryTextStyle(
                color: Banking_TextColorSecondary,
                size: 16,
                fontFamily: fontRegular))
            .onTap(() {
          finish(context);
        }),
        8.height,
        Divider(thickness: 1.0, color: Banking_greyColor.withOpacity(0.5)),
        8.height,
        Text(Banking_lbl_Other_Bank,
            style: primaryTextStyle(
                color: Banking_TextColorSecondary,
                size: 16,
                fontFamily: fontRegular))
            .onTap(() {
          finish(context);
        }),
        8.height,
        Divider(thickness: 1.0, color: Banking_greyColor.withOpacity(0.5)),
        8.height,
        Text(Banking_lbl_Credit_Card,
            style: primaryTextStyle(
                color: Banking_TextColorSecondary,
                size: 16,
                fontFamily: fontRegular))
            .onTap(() {
          finish(context);
        }),
        8.height,
      ],
    ),
  );
}

class CustomDialogBF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContentBenificier(context),
    );
  }
}

dialogContentBenificier(BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
    decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(10),
        backgroundColor: Banking_whitePureColor),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        8.height,
        Text("Mustapha BTZ",
            style: primaryTextStyle(
                color: Banking_TextColorSecondary,
                size: 16,
                fontFamily: fontRegular))
            .onTap(() {
          finish(context);
        }),
        8.height,
        Divider(thickness: 1.0, color: Banking_greyColor.withOpacity(0.5)),
        8.height,
        Text("Reda account",
            style: primaryTextStyle(
                color: Banking_TextColorSecondary,
                size: 16,
                fontFamily: fontRegular))
            .onTap(() {
          finish(context);
        }),
        8.height,
        Divider(thickness: 1.0, color: Banking_greyColor.withOpacity(0.5)),
        8.height,
        Text("Mustapha Account2",
            style: primaryTextStyle(
                color: Banking_TextColorSecondary,
                size: 16,
                fontFamily: fontRegular))
            .onTap(() {
          finish(context);
        }),
        8.height,
      ],
    ),
  );
}