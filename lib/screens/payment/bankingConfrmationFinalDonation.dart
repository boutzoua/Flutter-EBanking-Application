import 'package:banking/screens/payment/bankingOTPVerficationPayment.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:banking/constants/app_constants.dart';

import '../forget_password/otp_verification.dart';

class DonatonConfirmationFinalPage extends StatelessWidget {
  final String associationImage;
  final String associationInfo;
  final String donationName;
  final String donationAmount;
  final List<String> selectedDonations;

  DonatonConfirmationFinalPage({
    required this.associationImage,
    required this.associationInfo,
    required this.donationName,
    required this.donationAmount,
    required this.selectedDonations,
  });

  @override
  Widget build(BuildContext context) {
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
                  Icon(Icons.chevron_left, size: 30, color: Banking_blackColor).onTap(() {
                    finish(context);
                  }),
                  20.height,
                  Container(
                    width: 300,
                    padding: EdgeInsets.fromLTRB(12,20,20,20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topLeft,
                        colors: <Color>[Banking_Primary,Banking_palColor],
                      ),
                    ),
                    child: Text(
                      "Donation Confirmation",
                      style: boldTextStyle(size: 30, color: Banking_TextColorWhite),
                    ),
                  ),
                ],
              ),
              30.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    associationImage,
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(height: 30),
                  Text(
                    associationInfo,
                    style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Donation: $donationName', // Replace with the selected donation name
                    style: primaryTextStyle(size: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Amount: $donationAmount', // Replace with the selected donation amount
                    style: primaryTextStyle(size: 18),
                  ),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Selected Donations:', // Replace with your desired heading
                        style: boldTextStyle(size: 18),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: selectedDonations.length,
                        itemBuilder: (context, index) {
                          final donation = selectedDonations[index];
                          final reference = 'Reference ${index + 1}'; // Replace with your reference data
                          final description = 'Description ${index + 1}'; // Replace with your description data
                          final String price =donationAmount ; // Replace with your price data

                          return ListTile(
                            title: Text('$reference - $description',style: TextStyle(fontSize: 15),),
                            subtitle: Text('Price TTC: $price',style: TextStyle(fontSize: 15),),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Total Amount:', // Replace with your desired label
                    style: primaryTextStyle(size: 18),
                  ),
                  Text(
                    '500', // Replace with the total amount
                    style: boldTextStyle(size: 24),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topLeft,
                            colors: <Color>[Banking_Primary, Banking_palColor],
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            onPrimary: Colors.transparent,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              'Confirm',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Banking_TextColorWhite),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OTPVerificationPaymentPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            onPrimary: Colors.transparent,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Text(
                              'Cancel Operation',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Banking_TextColorWhite),
                            ),
                          ),
                          onPressed: () {
                            // Handle the cancel operation logic
                          },
                        ),
                      ),
                    ],
                  ),
                  20.height
                ],

              ),
            ],
          ),
        ),
      ),
    );
  }
}
