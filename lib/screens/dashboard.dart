import 'package:banking/screens/Transer/transfer_screen.dart';
import 'package:banking/screens/delivery/delivery_screen.dart';
import 'package:banking/screens/menu/menu_screen.dart';
import 'package:banking/screens/payment/bankingPayment_screen.dart';
import 'package:flutter/material.dart';
import 'package:banking/components/BankingBottomNavigationBar.dart';
import 'package:banking/constants/app_constants.dart';

import 'package:banking/screens/home/home_page_screen.dart';

class BankingDashboard extends StatefulWidget {
  static var tag = "/BankingDashboard";

  @override
  _BankingDashboardState createState() => _BankingDashboardState();
}

class _BankingDashboardState extends State<BankingDashboard> {
  var selectedIndex = 0;
  var pages = [
    HomePage(),
    BankingTransfer(),
    BankingPayment(),
    DeliveryScreen(),
    BankingMenu(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Banking_app_Background,
        bottomNavigationBar: BankingBottomNavigationBar(
          selectedItemColor: Banking_Primary,
          unselectedItemColor: Banking_greyColor.withOpacity(0.5),
          items: <BankingBottomNavigationBarItem>[
            BankingBottomNavigationBarItem(
                icon: "assets/logos/Banking_ic_Home.svg", title: Text(Banking_lbl_Home)),
            BankingBottomNavigationBarItem(
                icon: "assets/logos/Banking_ic_Payment.svg", title: Text(Banking_lbl_Transfer)),
            BankingBottomNavigationBarItem(
                icon: "assets/logos/Banking_ic_Transfer.svg", title: Text(Banking_lbl_Payment)),
            BankingBottomNavigationBarItem(
                icon: "assets/logos/delivery.svg", title: Text(Banking_lbl_Delivery)),
            BankingBottomNavigationBarItem(
                icon: "assets/logos/Banking_ic_Menu.svg", title: Text(Banking_lbl_Menu)),
          ],
          currentIndex: selectedIndex,
          unselectedIconTheme: IconThemeData(
              color: Banking_greyColor.withOpacity(0.5), size: 28),
          selectedIconTheme: IconThemeData(color: Banking_Primary, size: 28),
          onTap: _onItemTapped,
          type: BankingBottomNavigationBarType.fixed,
        ),
        body: SafeArea(
          child: pages[selectedIndex],
        ),
      ),
    );
  }
}