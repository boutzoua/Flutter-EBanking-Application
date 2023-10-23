import 'package:banking/components/changeNotifier.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:banking/constants/app_constants.dart';
import 'package:banking/components/widgets.dart';
import 'package:banking/components/banking_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static String tag = '/BankingHome1';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentIndexPage = 0;
  int? pageLength;

  late List<BankingHomeModel> mList1;
  late List<BankingHomeModel2> mList2;
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
  void initState(){
    super.initState();
    initializeData();
    currentIndexPage = 0;
    pageLength = 3;
    mList1=[];

  }


  Future<void> initializeData() async {
    await getTransaction();
  }

  Future<void> getTransaction() async {
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
        final transation = BankingHomeModel(
          amount: jsonItem['amount'],
          operationTime: jsonItem['userType'],
          type: jsonItem['service']['type'],
          name: jsonItem['service']['name'],
        );
        mList1.add(transation);

      }
      print("mliiit =================$mList1");


      }

  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    getTransaction();

    mList2= [BankingHomeModel2(
      title: "Payment 1",
      color: Colors.green,
      charge: "+3000Dhs",
      icon: "Icons.paypal",
    ),
      BankingHomeModel2(
        title: "Payment  2",
        color: Colors.green,
        charge: "+2000Dhs",
        icon: "Icons.paypal",
      ),
      BankingHomeModel2(
        title: "Payment  2",
        color: Colors.green,
        charge: "+2000Dhs",
        icon: "Icons.paypal",
      ),
      BankingHomeModel2(
        title: "Payment  2",
        color: Colors.green,
        charge: "+2000Dhs",
        icon: "Icons.paypal",
      ),
      BankingHomeModel2(
        title: "Payment  2",
        color: Colors.green,
        charge: "+2000Dhs",
        icon: "Icons.paypal",
      ),
    ];
    return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return [
              SliverAppBar(
                expandedHeight: 330,
                floating: false,
                pinned: true ,
                titleSpacing: 0,
                automaticallyImplyLeading: false,
                backgroundColor: innerBoxIsScrolled ? Banking_Primary:Banking_app_Background,
                actionsIconTheme: IconThemeData(opacity: 0.0),
                title: Container(
                  padding: EdgeInsets.fromLTRB(16, 42, 16, 32),
                  margin: EdgeInsets.only(bottom: 8,top: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/1mustapha-boutzoua1.jpg"),
                        radius: 24,
                      ),
                      10.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Hello ", style: primaryTextStyle(
                                color: Banking_TextColorWhite,
                                size: 16,
                                fontFamily: fontRegular,
                              ),
                              ),
                              Text(
                                user!.lastName.toString().toUpperCase(), style: primaryTextStyle(
                                color: Banking_TextColorWhite,
                                size: 16,
                                fontFamily: fontRegular,
                              ),
                              ),
                            ],
                          ),
                          Text(
                            "How are you",
                            style: primaryTextStyle(
                              color: Banking_TextColorWhite,
                              size: 16,
                              fontFamily: fontRegular,
                            ),
                          ),
                        ],
                      ).expand(),
                      Icon(
                        Icons.notifications, size: 30, color: Banking_whitePureColor,
                      )
                    ],
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Container(
                        height: 330,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topLeft,
                            colors: <Color>[Banking_Primary,Banking_palColor],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 80, 16, 8),
                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                        decoration: boxDecorationWithRoundedCorners(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: defaultBoxShadow()
                        ),
                        child: Column(
                          children: [
                              Container(
                                height: 130,
                                child: PageView(
                                  children: [
                                    TopCard(name: "Defaut Account", acno: '123456789', bal: "1200Dhs"),
                                    TopCard(name: "Second Account", acno: '477384738', bal: "8000Dhs"),
                                    TopCard(name: "Third Account", acno: '8493939200', bal: "5000Dhs"),
                                  ],
                                  onPageChanged: (value){
                                    setState(() {
                                      currentIndexPage = value;
                                    });
                                  },
                                ),
                              ),
                            8.height,
                            Align(
                              alignment: Alignment.center,
                              child: DotsIndicator(
                                dotsCount: 3,
                                position: currentIndexPage.toDouble(),
                                decorator: DotsDecorator(
                                  size:Size.square(8.0),
                                  activeSize: Size.square(8.0),
                                  color: Banking_TextColorPrimary,
                                ),
                              ),
                            ),
                            10.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  decoration: boxDecorationWithRoundedCorners(
                                    backgroundColor: Banking_Primary,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.payment,color: Banking_TextColorWhite,size: 24,),
                                      10.width,
                                      Text(
                                        "Payment",
                                        style: primaryTextStyle(
                                          size: 16,
                                          color: Banking_TextColorWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ).expand(),
                                10.width,
                                Container(
                                  padding: EdgeInsets.only(top: 8, bottom: 8,),
                                  decoration: boxDecorationWithRoundedCorners(
                                    backgroundColor: Banking_Primary,
                                    borderRadius: BorderRadius.circular(8.0)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset("assets/images/Banking_ic_Transfer.svg",
                                      color: Banking_TextColorWhite,),
                                      10.width,
                                      Text(
                                        "Transfer",
                                          style: primaryTextStyle(
                                              size: 16,
                                              color: Banking_TextColorWhite)
                                      )
                                    ],
                                  ),
                                ).expand(),
                              ],
                            ).paddingAll(10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Banking_app_Background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recently Transaction",
                          style: primaryTextStyle(
                              size: 16,
                              color: Banking_TextColorPrimary,
                              fontFamily: fontRegular)),
                      4.height,
                    ],
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: mList1.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: boxDecorationRoundedWithShadow(8,
                      backgroundColor: Banking_whitePureColor,
                      spreadRadius: 0,
                      blurRadius: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.account_balance_wallet,
                              size: 30, color: Banking_Primary),
                          5.width,
                          Text(mList1[index].name!,
                              style: primaryTextStyle(
                                  size: 10,
                                  color: Banking_TextColorPrimary,
                                  fontFamily: fontMedium))
                              .expand(),
                          5.width,
                          Text(mList1[index].type!,
                              style: primaryTextStyle(size: 10)),
                          5.width,
                          Text("${mList1[index].amount!}",
                              style: primaryTextStyle(
                                  color: Colors.green, size: 10)),
                          5.width,
                          Text("${mList1[index].operationTime!}",
                              style: primaryTextStyle( size: 10)),

                        ],
                      ),
                   );
                    }
                  ),
                  16.height,
                ],
              ),
            ),
          ),
        ),
    );
  }
}
