import 'package:banking/components/changeNotifier.dart';
import 'package:banking/components/theme_helper.dart';
import 'package:banking/screens/payment/bankingOTPVerficationPayment.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

import '../../components/banking_model.dart';

class RechargeScreen extends StatefulWidget {
  static var tag = "/BankingTermsCondition";
  const RechargeScreen({Key? key}) : super(key: key);

  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final _formKey = GlobalKey<FormState>();

  late int _selectedAmount;
  TextEditingController _phoneController = TextEditingController();
  late String token;
  late BankingServiceModel selectedProduct;
  late String _phoneNumber;


  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final userProvider = Provider.of<UserProvider>(context);
  //   final user = userProvider.user;
  //   token = user?.token ?? 'not avilaible';
  // }
  @override
  void initState() {
    super.initState();
    BankingServiceModel selectedProduct;
    _selectedAmount=0;
    _phoneNumber='';
    token='';
  }



  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    BankingServiceModel? selectedProduct = productProvider.selectedProduct;

    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    String _phoneNumber='';

    Future<void> payRecharge(int amount) async {
      String url = "$hostLink/operation/pay-recharge";
      var uri = Uri.parse(url);
      print(uri);
      var res = await http.post(uri,
          headers: {'Content-Type': 'application/json','Authorization': 'Bearer ${user!.token}' },
          body: json.encode({
            "serviceId": selectedProduct?.idService,
            "amount": amount,
          }));
      print("${res.body}");
      if (res.statusCode >= 200 && res.statusCode < 203) {
        print("status==============================================="+ res.statusCode.toString());

      }
    }

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
                    child: Text("Recharge Payment",
                        style: boldTextStyle(
                            size: 30, color: Banking_TextColorWhite)),
                  ),
                ],
              ),
              20.height,
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Select Recharge Amount:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      RadioListTile(
                        title: Text('5 Dh'),
                        value: 5,
                        groupValue: _selectedAmount,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedAmount = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('10 Dh'),
                        value: 10,
                        groupValue: _selectedAmount,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedAmount = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('20 Dh'),
                        value: 20,
                        groupValue: _selectedAmount,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedAmount = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('50 Dh'),
                        value: 50,
                        groupValue: _selectedAmount,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedAmount = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('100 Dh'),
                        value: 100,
                        groupValue: _selectedAmount,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedAmount = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('\$200'),
                        value: 200,
                        groupValue: _selectedAmount,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedAmount = value!;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Phone Number:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      20.height,
                      Container(
                        margin: EdgeInsets.only(right: 7,left: 7),
                        child: TextFormField(
                          decoration: ThemeHelper().textInputDecoration('Phone Number', 'Enter your phone Number'),
                          onChanged: (val) {
                                _phoneNumber = val;
                          },
                          keyboardType: TextInputType.phone,
                          validator: (val){
                            if (val!.isEmpty) {
                              return "Please enter your phoneNumber";
                            }
                            return null;
                          },
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                  child: Text(
                                    'Valid'.toUpperCase(),
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                                onPressed: () {
                                  if(_formKey.currentState!.validate()){
                                    int selectedAmount = _selectedAmount;
                                    // String phoneNumber = _phoneController.text;
                                    print("============================= ${_selectedAmount}");

                                    // Perform the payment with the selected amount and phone number
                                    setState(() {
                                      if(selectedAmount!=0) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Payment Confirmation'),
                                              content: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                      'Recharge Amount: $selectedAmount'),
                                                  SizedBox(height: 10),
                                                  Text('Phone Number: ${_phoneNumber}'),
                                                ],
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    payRecharge(_selectedAmount);
                                                    print("===========idServices ${selectedProduct?.idService}");
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OTPVerificationPaymentPage(),
                                                      ),
                                                    );
                                                  },
                                                  child: Text('Confirm'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Handle payment cancellation
                                                    finish(context);
                                                  },
                                                  child: Text('Cancel'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    });
                                  }
                                }
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
