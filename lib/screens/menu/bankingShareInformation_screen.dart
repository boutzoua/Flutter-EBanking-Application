import 'package:banking/components/changeNotifier.dart';
import 'package:banking/components/data_generator.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:banking/components/banking_model.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:provider/provider.dart';

class BankingShareInformation extends StatefulWidget {
  static var tag = "/BankingShareInformation";

  @override
  _BankingShareInformationState createState() =>
      _BankingShareInformationState();
}

class _BankingShareInformationState extends State<BankingShareInformation> {
  late List<BankingShareInfoModel> mList1;

  @override
  void initState() {
    super.initState();
    mList1 = bankingInfoList();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      backgroundColor: Banking_app_Background,
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              30.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.chevron_left, size: 30, color: Banking_blackColor)
                      .onTap(
                        () {
                      finish(context);
                    },
                  ),
                  30.height,
                  Container(
                    width: 300,
                    padding: EdgeInsets.fromLTRB(12,30,20,30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topLeft,
                        colors: <Color>[Banking_Primary,Banking_palColor],
                      ),
                    ),
                    child: Text("Share\nInformation",
                        style: boldTextStyle(
                            size: 30, color: Banking_TextColorWhite)),
                  ),
                ],
              ),
              20.height,
              Row(
                children: <Widget>[
                  CircleAvatar(
                      backgroundImage: AssetImage("assets/images/1mustapha-boutzoua1.jpg"),
                      radius: 25),
                  10.width,
                  Text(user!.fullName.toString(),
                      style: boldTextStyle(
                          color: Banking_TextColorPrimary, size: 24))
                      .center(),
                ],
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(Banking_lbl_Account_Number,
                      style: primaryTextStyle(
                          color: Banking_TextColorPrimary,
                          size: 18,
                          fontFamily: fontSemiBold)),
                  Text(user!.phoneNumber.toString(),
                      style:
                      primaryTextStyle(size: 18, fontFamily: fontSemiBold)),
                ],
              ),
              Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(Banking_lbl_Bank,
                      style: primaryTextStyle(
                          color: Banking_TextColorPrimary,
                          size: 18,
                          fontFamily: fontSemiBold)),
                  Text("JabekLah Bank",
                      style:
                      primaryTextStyle(size: 18, fontFamily: fontSemiBold)),
                ],
              ).paddingOnly(bottom: spacing_middle),
              Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(Banking_lbl_Branch,
                      style: primaryTextStyle(
                          color: Banking_TextColorPrimary,
                          size: 18,
                          fontFamily: fontSemiBold)),
                  Text("Casa-Blanca",
                      style:
                      primaryTextStyle(size: 18, fontFamily: fontSemiBold)),
                ],
              ),
              Divider(height: 24),
              Text(Banking_lbl_QR_Code,
                  style: primaryTextStyle(
                      color: Banking_TextColorPrimary,
                      size: 18,
                      fontFamily: fontSemiBold)),
              20.height,
              Image.asset("assets/images/Banking_ic_QR.png",
                  height: 100, width: 100, fit: BoxFit.fill)
                  .center(),
              20.height,
              Text(Banking_lbl_Share_Info,
                  style: primaryTextStyle(
                      color: Banking_TextColorPrimary,
                      size: 18,
                      fontFamily: fontSemiBold)),
              40.height,
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mList1.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(right: spacing_standard_new),
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 20,
                      width: 50,
                      margin: EdgeInsets.only(right: 16),
                      padding: EdgeInsets.all(8),
                      decoration: boxDecorationWithShadow(
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor: Banking_whitePureColor,
                          boxShadow: defaultBoxShadow()),
                      child:
                      Image.asset(mList1[index].icon, height: 30, width: 30)
                          .center(),
                    );
                  },
                ),
              ).center(),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}