import 'package:banking/components/banking_model.dart';
import 'package:banking/components/changeNotifier.dart';
import 'package:banking/components/theme_helper.dart';
import 'package:banking/screens/payment/bankingDoationSelectionPayment.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DonationScreen extends StatefulWidget {
  static var tag = "/BankingTermsCondition";

  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  late int amount;
  late String donorname;

  List<Donation> _donation = [
    // Facture(description: 'Facture 1', amount: 50),
    // Facture(description: 'Facture 2', amount: 100),
    // Facture(description: 'Facture 3', amount: 150),
  ];

  late String token='';
  final _formKey = GlobalKey<FormState>();

  Future<void> initializeData() async {
    await getUnpaidFacture();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    token= user?.token ?? 'not avilaible';
    initializeData();
  }

  @override
  void initState() {
    super.initState();
    initializeData();
    amount=0;
    donorname='';
    // ProductProvider productProvider = Provider.of<ProductProvider>(context);
    // BankingServiceModel? selectedProduct = productProvider.selectedProduct;
  }

  Future<void> getUnpaidFacture() async {
    String url = "$hostLink/operation/paidBills";
    var uri = Uri.parse(url);
    print("================$uri");
    print("================${token}");
    var res = await http.get(uri,
      headers: {'Authorization': 'Bearer ${token}',},
    );
    print("=====================${res.body}");
    if (res.statusCode >= 200 && res.statusCode < 300) {
      var jsonResponse = json.decode(res.body);


      for (var jsonItem in jsonResponse) {
        final facture = Donation(
          id: jsonItem['id'],
          amount: jsonItem['amount'],
          name: jsonItem['service']['agency']['name'],
        );
        _donation.add(facture);

      }
      print("fscture =================$_donation");


    }

  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

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
                  Icon(Icons.chevron_left, size: 30, color: Banking_blackColor)
                      .onTap(
                        () {
                      finish(context);
                    },
                  ),
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
                    child: Text("Donation Payment",
                        style: boldTextStyle(
                            size: 30, color: Banking_TextColorWhite)),
                  ),
                ],
              ),
              30.height,
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/alcs_maroc.png', // Replace with the path to your association image
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.only(right: 10,left: 10),
                    child: TextFormField(
                      decoration: ThemeHelper().textInputDecoration('Donor Name', 'Enter your Donor name'),
                      onChanged: (val) {
                        donorname= val;
                      },
                      validator: (val){
                        if (val!.isEmpty) {
                          return "Please enter your donorname";
                        }
                        return null;
                      },
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  ),
                  10.height,
                  Container(
                    margin: EdgeInsets.only(right: 10,left: 10),
                    child: TextFormField(
                      decoration: ThemeHelper().textInputDecoration('Amount', 'Enter your amount'),
                      onChanged: (val) {
                           amount = val as int;
                      },
                      keyboardType: TextInputType.number,
                      validator: (val){
                        if (val!.isEmpty) {
                          return "Please enter your amount";
                        }
                        return null;
                      },
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Text('Donate'.toUpperCase(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                          ),
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              //After successful login we will redirect to profile page. Let's create profile page now
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DonationSelectionScreen(associationName: "ALCS", creance: "SIdation", donorName: donorname, amount: amount,),
                                  ),
                                );
                              });
                            }

                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Text('Cancel'.toUpperCase(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                          ),
                          onPressed: (){
                            Navigator.pop(context);

                          },
                        ),
                      ),
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