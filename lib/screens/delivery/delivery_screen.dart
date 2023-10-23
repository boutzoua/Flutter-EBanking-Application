import 'package:banking/components/changeNotifier.dart';
import 'package:banking/screens/delivery/bankingProductDetailsscreen.dart';
import 'package:banking/screens/payment/bankigPaymentFactureScreen.dart';
import 'package:banking/screens/payment/bankingDonationScreen.dart';
import 'package:banking/screens/payment/bankingPaymentDetails_screen.dart';
import 'package:banking/screens/payment/bankingRechargeScreen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:filter_list/filter_list.dart';

import 'package:banking/components/banking_model.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:banking/components/data_generator.dart';
import 'package:provider/provider.dart';

class DeliveryScreen extends StatefulWidget {
  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  late List<BankingDeliveryModel> mList;
  List<String> selectedCategories = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    setStatusBarColor(Banking_app_Background);
    mList = bankingDeliveryList();
  }

  List<BankingDeliveryModel> getFilteredProducts() {
    return mList.where((product) {
      return product.name!.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = getFilteredProducts();

    return Scaffold(
      backgroundColor: Banking_app_Background,
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              10.height,
              Text(Banking_lbl_Delivery,
                  style: boldTextStyle(
                      color: Banking_TextColorPrimary, size: 35)),
              8.height,
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search for Product name",
                  labelStyle: primaryTextStyle(
                      size: textSizeLargeMedium.toInt(),
                      color: Banking_greyColor),
                  suffixIcon:
                  Icon(Icons.search, size: 30, color: Banking_greyColor),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Banking_greyColor)),
                ),
              ),
              10.height,
              GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: filteredProducts.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return Container(
                    margin: EdgeInsets.only(
                        left: 6, right: 6, top: 6, bottom: 6),
                    decoration: boxDecorationWithShadow(
                        backgroundColor: Banking_whitePureColor,
                        boxShadow: defaultBoxShadow(),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            product.img!,
                            height: 200,
                            width: 300,
                          ),
                          15.height,
                          Container(
                            margin: EdgeInsets.only(right: 10,left: 10),
                            padding: EdgeInsets.fromLTRB(12,20,20,20),
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topLeft,
                                colors: <Color>[Banking_Primary,Banking_palColor],
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Product name: ${product.name!}",
                                  style: primaryTextStyle(size: 16, color: Colors.white),
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                ),
                                Text(
                                  "Quantite: ${product.qte!}",
                                  style: primaryTextStyle(size: 16, color: Colors.white),
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                ),
                                Text(
                                  "Prcie: ${product.price! }",
                                  style: primaryTextStyle(size: 16, color: Colors.white),
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).onTap(() {
                      // Navigate to the payment facture page
                    ItemProvider itemProvider = Provider.of<ItemProvider>(context, listen: false);
                    itemProvider.setProduct(product);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(),
                        ),
                      );
                  });
                  // BankingPaymentDetails(headerText: product.title)
                  //     .launch(context);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
