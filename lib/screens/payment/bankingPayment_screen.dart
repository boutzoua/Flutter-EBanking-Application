import 'package:banking/components/changeNotifier.dart';
import 'dart:convert';
import 'package:banking/screens/payment/bankigPaymentFactureScreen.dart';
import 'package:banking/screens/payment/bankingDonationScreen.dart';
import 'package:banking/screens/payment/bankingPaymentDetails_screen.dart';
import 'package:banking/screens/payment/bankingRechargeScreen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;
import 'package:banking/components/banking_model.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:banking/components/data_generator.dart';
import 'package:provider/provider.dart';

class BankingPayment extends StatefulWidget {
  static var tag = "/BankingPayment";
  @override
  _BankingPaymentState createState() => _BankingPaymentState();
}


class _BankingPaymentState extends State<BankingPayment> {
  late List<BankingServiceModel> mList = [];
  List<String> selectedCategories = [];
  String searchText = '';
  late String token='';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    token = user?.token ?? 'not avilaible';
    selectedCategories;
    fetchServices();
    getFilteredProducts();
  }



  @override
  void initState(){
    super.initState();
    setStatusBarColor(Banking_app_Background);
    initializeData();
    getFilteredProducts();
  }

  Future<void> initializeData() async {
    await fetchServices();
  }

  Future<void> fetchServices() async {
      String url = "$hostLink/service";
      var uri = Uri.parse(url);
      print("============={$token}");
      // final String authToken = token; // Replace with your actual authorization token
      print(uri);
      var res = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      // if (res.statusCode >= 200 && res.statusCode < 299) {
        var jsonResponse = json.decode(res.body);
        print('=================jsoresponse==={$jsonResponse}');

        for (var jsonItem in jsonResponse) {
          String id = jsonItem['id'];
          String title = jsonItem['name'];
          String img = jsonItem['agency']['image'];
          String category = jsonItem['type'];

          BankingServiceModel serviceModel = BankingServiceModel(
            idService: id,
            nameService: title,
            img: img,
            category: category,
          );

          mList.add(serviceModel);
        }
      // } else {
        // Handle error cases
        print('HTTP request failed with status: ${res.statusCode}');
      // }
    //   return servicePaymentModel;
    // }
  }

  List<BankingServiceModel> getFilteredProducts() {
    return mList.where((product) {
      return selectedCategories.isEmpty ||
          selectedCategories.contains(product.category);
    }).where((product) {
      return product.nameService!.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // final user = userProvider.user;
    // final String? token = user?.token;

    // mList = saveServices(token!) as List<BankingServiceModel>;
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
              Text(Banking_lbl_Payment,
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
                  hintText: "Search for Creancier",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: categories
                    .map((category) => FilterChip(
                  padding: EdgeInsets.all(10.0),
                  selectedColor: Banking_Primary,
                  selectedShadowColor: Banking_blackColor,
                  labelStyle: TextStyle(
                    fontSize: 12.0,
                    color: selectedCategories.contains(category)
                        ? Colors.white
                        : Colors.black,
                  ),
                  selected: selectedCategories.contains(category),
                  label: Text(category),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedCategories.add(category);
                      } else {
                        selectedCategories.remove(category);
                      }
                    });
                  },
                ))
                    .toList(),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.network(
                          product.img!,
                          height: 110,
                          width: 110,
                        ),
                        15.height,
                        Text(
                          product.nameService!,
                          style: primaryTextStyle(size: 16),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ).onTap(() {
                    ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);
                    productProvider.setProduct(product);
                    if (product.category == 'FACTURE') {
                    // Navigate to the payment facture page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentFactureScreen(),
                          ),
                    );
                    } else if (product.category == 'RECHARGE') {
                    // Navigate to the recharge page
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => RechargeScreen(),
                            ),
                    );
                    } else if (product.category == 'DONATION') {
                    // Navigate to the donation page
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => DonationScreen(),
                          ),
                    );
                    }
                    });
                    // BankingPaymentDetails(headerText: product.title)
                    //     .launch(context);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
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
