import 'package:banking/components/banking_model.dart';
import 'package:banking/components/changeNotifier.dart';
import 'package:banking/components/theme_helper.dart';
import 'package:banking/screens/payment/bankingOTPVerficationPayment.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentFactureScreen extends StatefulWidget {
  static var tag = "/BankingTermsCondition";

  @override
  _PaymentFactureScreenState createState() => _PaymentFactureScreenState();
}

class _PaymentFactureScreenState extends State<PaymentFactureScreen> {
  List<Facture> _factures = [
    // Facture(description: 'Facture 1', amount: 50),
    // Facture(description: 'Facture 2', amount: 100),
    // Facture(description: 'Facture 3', amount: 150),
  ];
  List<bool> _selectedFactures = [];
  late FToast fToast;

  late String token='';

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
    _selectedFactures = List<bool>.filled(_factures.length, false);
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
    initializeData();
    // ProductProvider productProvider = Provider.of<ProductProvider>(context);
    // BankingServiceModel? selectedProduct = productProvider.selectedProduct;
  }
  double getTotalAmount() {
    double total = 0;
    for (int i = 0; i < _factures.length; i++) {
      if (_selectedFactures[i]) {
        total += _factures[i].amount;
      }
    }
    return total;
  }
  bool areAllFacturesUnchecked() {
    for (int i = 0; i < _selectedFactures.length; i++) {
      if (_selectedFactures[i]) {
        return false;
      }
    }
    return true;
  }

  Future<void> initializeData() async {
    await getUnpaidFacture();
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
        final facture = Facture(
          id: jsonItem['id'],
          amount: jsonItem['amount'],
          image: jsonItem['userType'],
          type: jsonItem['service']['type'],
          name: jsonItem['service']['agency']['name'],
        );
        _factures.add(facture);

      }
      print("fscture =================${_factures}");


    }

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
                    child: Text("Facture Payment",
                        style: boldTextStyle(
                            size: 30, color: Banking_TextColorWhite)),
                  ),
                ],
              ),
              20.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Company Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Company Description',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Select Factures to Pay:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _factures.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Banking_whitePureColor,
                        child: CheckboxListTile(
                          title: Text("${_factures[index].type}   ${_factures[index].type}"),
                          subtitle: Text('Amount: \$${_factures[index].amount}'),
                          value: _selectedFactures[index],
                          onChanged: (bool? value) {
                            setState(() {
                              _selectedFactures[index] = value!;
                            });
                          },
                        ),
                      );
                    },
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
                              if(!areAllFacturesUnchecked()){
                                // Perform the payment with the selected amount and phone number
                                setState(() {
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
                                                  'Total Bill Amount: ${getTotalAmount()}'),
                                              SizedBox(height: 10),
                                              Text('Bill Owner : '),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                finish(context);
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
                                });
                              }else{
                                _showToast("You should to choose 1 bill", Colors.red);
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  _showToast(String name, Color color) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(name,style: TextStyle(fontSize: 10),),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 1),
    );

  }

}