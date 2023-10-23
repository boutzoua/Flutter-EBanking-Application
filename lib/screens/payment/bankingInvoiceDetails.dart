import 'package:banking/components/BankingSlider.dart';
import 'package:banking/screens/Transer/transferSuccessful.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:banking/components/widgets.dart';

class BankingInvoiceDetail extends StatefulWidget {
  static var tag = "/BankingInvoiceDetail";

  @override
  _BankingInvoiceDetailState createState() => _BankingInvoiceDetailState();
}

class _BankingInvoiceDetailState extends State<BankingInvoiceDetail> {
  bool isGetOtp = false;
  var tapCount = 0;

  void tappedConfirm() {
    if (tapCount != 1) {
      BankingTransferSuccessful().launch(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Banking_app_Background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: spacing_standard_new),
            headerView(Banking_lbl_Pay_Voice, width * 0.34, context),
            Text("Choose Account to Transfer",
                style: secondaryTextStyle(
                    color: Banking_TextColorSecondary,
                    size: 14,
                    fontFamily: fontRegular))
                .paddingOnly(
                left: spacing_standard_new, top: spacing_standard_new),
            16.height,
            BankingSliderWidget(),
            Text("Invoice Mar 2020",
                style: secondaryTextStyle(
                    color: Banking_TextColorSecondary,
                    size: 14,
                    fontFamily: fontRegular))
                .paddingOnly(
                left: spacing_standard_new, top: spacing_standard_new),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Name",
                        style: primaryTextStyle(
                            color: Banking_TextColorSecondary,
                            size: 18,
                            fontFamily: fontRegular))
                        .paddingOnly(
                        left: spacing_standard_new,
                        top: spacing_standard_new),
                    Text("Mustapha BTZ",
                        style: primaryTextStyle(
                            color: Banking_TextColorPrimary,
                            size: 18,
                            fontFamily: fontRegular))
                        .paddingOnly(
                        right: spacing_standard_new,
                        top: spacing_standard_new),
                  ],
                ),
                Divider().paddingOnly(
                    left: spacing_standard, right: spacing_standard)
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Address",
                        style: primaryTextStyle(
                            color: Banking_TextColorSecondary,
                            size: 18,
                            fontFamily: fontRegular))
                        .paddingOnly(
                        left: spacing_standard_new,
                        top: spacing_standard_new),
                    Text("Gueliz-Marrakech",
                        style: primaryTextStyle(
                            color: Banking_TextColorPrimary,
                            size: 18,
                            fontFamily: fontRegular))
                        .paddingOnly(
                        right: spacing_standard_new,
                        top: spacing_standard_new),
                  ],
                ),
                Divider().paddingOnly(
                    left: spacing_standard, right: spacing_standard)
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Code",
                        style: primaryTextStyle(
                            color: Banking_TextColorSecondary,
                            size: 18,
                            fontFamily: fontRegular))
                        .paddingOnly(
                        left: spacing_standard_new,
                        top: spacing_standard_new),
                    Text("#7783",
                        style: primaryTextStyle(
                            color: Banking_TextColorPrimary,
                            size: 18,
                            fontFamily: fontRegular))
                        .paddingOnly(
                        right: spacing_standard_new,
                        top: spacing_standard_new),
                  ],
                ),
                Divider().paddingOnly(
                    left: spacing_standard, right: spacing_standard)
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("TimeService",
                        style: primaryTextStyle(
                            color: Banking_TextColorSecondary,
                            size: 18,
                            fontFamily: fontRegular))
                        .paddingOnly(
                        left: spacing_standard_new,
                        top: spacing_standard_new),
                    Text("25 Jan - 25 Feb",
                        style: primaryTextStyle(
                            color: Banking_TextColorPrimary,
                            size: 18,
                            fontFamily: fontRegular))
                        .paddingOnly(
                        right: spacing_standard_new,
                        top: spacing_standard_new),
                  ],
                ),
                Divider().paddingOnly(
                    left: spacing_standard, right: spacing_standard)
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Amount Transaction",
                        style: primaryTextStyle(
                            color: Banking_TextColorSecondary,
                            size: 18,
                            fontFamily: fontRegular))
                        .paddingOnly(
                        left: spacing_standard_new,
                        top: spacing_standard_new),
                    Text("\$200",
                        style: primaryTextStyle(
                            color: Banking_TextColorPrimary,
                            size: 18,
                            fontFamily: fontRegular))
                        .paddingOnly(
                        right: spacing_standard_new,
                        top: spacing_standard_new),
                  ],
                ),
                Divider().paddingOnly(
                    left: spacing_standard, right: spacing_standard)
              ],
            ),
            16.height,
            Divider(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("A OTP code has been send to your phone",
                    style: primaryTextStyle(
                        color: Banking_TextColorSecondary,
                        size: 14,
                        fontFamily: fontRegular)),
                5.height,
                Container(
                  width: 280,
                    child: EditText(text: "Enter OTP", isPassword: false)
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(Banking_lbl_Resend,
                        style: primaryTextStyle(color: Colors.blue,
                            size: 18, fontFamily: fontRegular))
                        .onTap(() {}),
                  ),
                ),
              ],
            ).visible(isGetOtp == true),
            Center(
              child: Container(
                color: Colors.deepPurple,
                width: 140,
                height: 56,
                child: BankingButton(
                    textContent: isGetOtp == true
                        ? Banking_lbl_Pay
                        : Banking_lbl_Get_OTP,
                    onPressed: () {
                      setState(
                            () {
                          isGetOtp = true;
                          tapCount = tapCount + 1;
                          tappedConfirm();

                        },
                      );
                })
                    .paddingOnly(
                    top: spacing_standard_new,
                    left: spacing_standard_new,
                    right: spacing_standard_new,
                    bottom: spacing_standard_new),
              ),
            ),
            20.height
          ],
        ),
      ),
    );
  }
}