import 'package:banking/components/theme_helper.dart';
import 'package:banking/screens/payment/bankingConfrmationFinalDonation.dart';
import 'package:flutter/material.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DonationSelectionScreen extends StatefulWidget {

  final String associationName;
  final String creance;
  final String donorName;
  final int amount;



  DonationSelectionScreen({
    required this.associationName,
    required this.creance,
    required this.donorName,
    required this.amount,
  });

  @override
  _DonationSelectionScreenState createState() => _DonationSelectionScreenState();
}

class _DonationSelectionScreenState extends State<DonationSelectionScreen> {
  List<String> selectedDonations = [];

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
                    padding: EdgeInsets.fromLTRB(12, 20, 20, 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topLeft,
                        colors: <Color>[Banking_Primary, Banking_palColor],
                      ),
                    ),
                    child: Text(
                      "Donation Payment",
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
                    'assets/images/alcs_maroc.png',
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Association: ${widget.associationName}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Date de creation: 12/10/2010',
                    style: TextStyle(fontSize: 16,),
                  ),
                  10.height,
                  Text(
                    'Creance: ${widget.creance}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Donor: ${widget.donorName}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 30),
                  Container(
                    color: Banking_whitePureColor,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5, // Replace with the actual number of donations
                      itemBuilder: (context, index) {
                        final donation = 'Donation ${index + 1}';
                        final amount = '100';
                        final isSelected = selectedDonations.contains(donation);

                        return ListTile(
                          title: Text('$donation     -     $amount Dhs'),
                          trailing: Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                if (value != null && value) {
                                  selectedDonations.add(donation);
                                } else {
                                  selectedDonations.remove(donation);
                                }
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Total Amount: ${selectedDonations.length * 100} Dhs',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Text(
                              'Valid'.toUpperCase(),
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            if (selectedDonations.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DonatonConfirmationFinalPage(associationImage: "assets/images/alcs_maroc.png", associationInfo: "ALCS", donationName: "Mustapha", donationAmount: "100", selectedDonations: selectedDonations),
                                ),
                              );
                            }else{
                              Fluttertoast.showToast(
                                  msg: "You should to choose one item",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Text(
                              'Cancel'.toUpperCase(),
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
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
