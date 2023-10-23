import 'package:banking/components/banking_model.dart';
import 'package:banking/constants/app_constants.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
//
//
List<BankingShareInfoModel> bankingInfoList() {
  List<BankingShareInfoModel> list = [];

  var list1 = BankingShareInfoModel("assets/images/Banking_ic_Whatsup.png");
  list.add(list1);

  var list2 = BankingShareInfoModel("assets/images/Banking_ic_messenger.png");
  list.add(list2);

  var list3 = BankingShareInfoModel("assets/images/Banking_ic_Skype.png");
  list.add(list3);

  var list4 = BankingShareInfoModel("assets/images/Banking_ic_Inst.png");
  list.add(list4);

  var list5 = BankingShareInfoModel("assets/images/Banking_ic_facebook.png");
  list.add(list5);

  return list;
}

List<BankingShareInfoModel> bankingNewsList() {
  List<BankingShareInfoModel> list = [];

  var list1 = BankingShareInfoModel("assets/images/Banking_ic_walk2.jpg");
  list.add(list1);

  var list2 = BankingShareInfoModel("assets/images/Banking_ic_walk2.jpg");
  list.add(list2);

  var list3 = BankingShareInfoModel("assets/images/Banking_ic_walk2.jpg");
  list.add(list3);

  return list;
}
//
List<BankingQuesAnsModel> bankingQuestionList() {
  List<BankingQuesAnsModel> list = [];

  var list1 = BankingQuesAnsModel("Question: lorem ipsum doller sit ?");
  list.add(list1);

  var list2 = BankingQuesAnsModel(
      "Money return when you go shopping with credit card of Cy Captial Bank ?");
  list.add(list2);

  var list3 = BankingQuesAnsModel(
      "Each payment process is so simple and hassle - free ?");
  list.add(list3);

  var list4 = BankingQuesAnsModel(
      "Jabak Lah Bank give a giftbox for new customers who create account ?");
  list.add(list4);

  var list5 = BankingQuesAnsModel(
      "Each payment process is so simple and hassle - free ?");
  list.add(list5);

  var list6 = BankingQuesAnsModel(
      "Money return when you go shopping with credit card of Jabak LAh Bank ?");
  list.add(list6);

  return list;
}
//
// List<BankingSavingModel> bankingSavingList() {
//   List<BankingSavingModel> list = [];
//
//   var list1 = BankingSavingModel(
//       title: "Saving 1",
//       date: "22 Apr 2020",
//       rs: "\$12,000",
//       interest: "Interest 8 % - 8 Months");
//   list.add(list1);
//
//   var list2 = BankingSavingModel(
//       title: "Saving 2",
//       date: "22 Mar 2020",
//       rs: "\$20,000",
//       interest: "Interest 4 % - 2 Months");
//   list.add(list2);
//
//   return list;
// }
//

Future<List<BankingServiceModel>> saveServices(String token) async {
  String url = "$hostLink/service";
  var uri = Uri.parse(url);
  final String authToken = token; // Replace with your actual authorization token
  print(uri);
  var res = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    },
  );

  List<BankingServiceModel> servicePaymentModel = [];

  if (res.statusCode >= 200 && res.statusCode < 202) {
    var jsonResponse = json.decode(res.body);

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

      servicePaymentModel.add(serviceModel);
    }
  } else {
    // Handle error cases
    print('HTTP request failed with status: ${res.statusCode}');
  }

  return servicePaymentModel;
}


Future<List> unPaidFacture(String token) async {
  String url = "$hostLink/operation/unpaidBills";
  var uri = Uri.parse(url);
  final String authToken = token; // Replace with your actual authorization token
  print(uri);
  var res = await http.get(uri,
      headers: {'Content-Type': 'application/json', 'Authorization':'Bearer $authToken'},);
  List<BankingUnPaidFacture> unpaidFactureModels = [];
  if (res.statusCode >= 200 && res.statusCode < 202) {
    var jsonResponse = json.decode(res.body);
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    for (var jsonBilledItem in jsonResponse) {
      double id = jsonBilledItem['id'];
      double amount = jsonBilledItem['amount'];
      String title = jsonBilledItem['name'];
      String operationStatus = jsonBilledItem['operationStatus'];
      String clientId = jsonBilledItem['clientId'];
      String clientUsename = jsonBilledItem['clientUsername'];
      String clientEmail = jsonBilledItem['clientEmail'];
      String img = jsonBilledItem['service']['agency']['image'];
      String immId = jsonBilledItem['service']['agency']['immId'];
      String idService = jsonBilledItem['service']['id'];
      String nameService = jsonBilledItem['service']['name'];
      String category = jsonBilledItem['service']['type'];

      BankingUnPaidFacture unpaidFacture = BankingUnPaidFacture(
              id:id ,
              nameService: '',
              idService: '',
            clientid : '',
           immId : '',
            nameAgency: "",
            clientUsername:  "",
            clientEmail : "",
           amount : 0.0,
           img : '',
           category : '',
      );
      unpaidFactureModels.add(unpaidFacture);
    }

  } else {
    // Handle error cases
    print('HTTP request failed with status: ${res.statusCode}');
  }
  return unpaidFactureModels;
}


// List<BankingServiceModel> bankingPaymentList() {
//   List<BankingServiceModel> list = [];
//
//   var list1 = BankingServiceModel(
//       title: "ONEE FACTURES",
//       img: "assets/images/Banking_ic_Eletronics.png",
//       category: "facture");
//   list.add(list1);
//
//   var list2 =
//   BankingServiceModel(title: "LYDEC FACTURES",
//       img: "assets/images/Banking_ic_WaterDrop.png",
//       category: "facture");
//   list.add(list2);
//
//   var list5 =
//   BankingServiceModel(title: "REDAL FACTURES",
//       img: "assets/images/Redal-removebg-preview.png",
//       category: "facture");
//   list.add(list5);
//
//   var list9 =
//   BankingServiceModel(title: "AMENDUS FACTURES",
//       img: "assets/images/AMENDIS-1-removebg-preview.png",
//       category: "facture");
//   list.add(list9);
//
//   var list3 = BankingServiceModel(
//       title: "IAM FACTURES",
//       img: "assets/images/Maroc-Telecom-logo.png",
//       category: "facture"
//       );
//   list.add(list3);
//   var list4 = BankingServiceModel(
//     title: "IAM RECHARGES",
//     img: "assets/images/Maroc-Telecom-logo.png",
//       category: "recharge"
//   );
//   list.add(list4);
//
//   var list6 = BankingServiceModel(
//     title: "INWI RECHARGES",
//     img: "assets/images/logo_inwi.png",
//       category: "recharge"
//   );
//   list.add(list6);
//
//   var list7 = BankingServiceModel(
//     title: "INWI FACTURES",
//     img: "assets/images/logo_inwi.png",
//       category: "facture"
//   );
//   list.add(list7);
//   var list8 = BankingServiceModel(
//       title: "ALCS Maroc",
//       img: "assets/images/alcs_maroc.png",
//       category: "donation"
//   );
//   list.add(list8);

  // var list8 = BankingPaymentModel(
  //     title: "Mobile PrePaid",
  //     img: "assets/images/Banking_ic_Moblie.png",
  //     );
  // list.add(list8);

  //
  // var list10 = BankingPaymentModel(
  //     title: "Shopping Online",
  //     img: Banking_ic_ShoppingCart,
  //     color: Banking_Primary);
  // list.add(list10);
  //
  // var list11 = BankingPaymentModel(
  //     title: "Booking Hotel",
  //     img: Banking_ic_Hotel,
  //     color: Banking_greenLightColor);
  // list.add(list11);

//   return list;
// }


List<BankingDeliveryModel> bankingDeliveryList() {
  List<BankingDeliveryModel> list = [];

  var list1 = BankingDeliveryModel(
      name: "iPhone 14 pro max",
      img: "assets/images/iphone14.png",
      description: "Product Name: Product X\nDescription: \nProduct X is a high-quality and versatile product designed to meet your everyday needs. With its sleek design and advanced features, it provides exceptional performance and convenience. Whether you're using it at home or on the go, Product X delivers outstanding results.\n\nKey Features:\n- Durable and lightweight construction for easy portability.\n- Advanced technology that ensures efficient and reliable operation.\n- Multiple functions and modes to cater to various tasks and preferences.\n- User-friendly interface with intuitive controls for effortless operation.\n- Wide compatibility with other devices and accessories for enhanced versatility.\n- Long-lasting battery life to keep you productive throughout the day.\n\nProduct X is the perfect choice for anyone seeking a reliable and efficient solution. Its exceptional quality and performance make it a must-have for every modern individual. Experience the convenience and effectiveness of Product X and elevate your daily activities to new heights.\n\n",
      agencyName: "IAM", qte: 100, price: 1000);
  list.add(list1);

  var list2 =
  BankingDeliveryModel(name: "iPhone 12 pro",
      description: "Product Name: Product X\nDescription: \nProduct X is a high-quality and versatile product designed to meet your everyday needs. With its sleek design and advanced features, it provides exceptional performance and convenience. Whether you're using it at home or on the go, Product X delivers outstanding results.\n\nKey Features:\n- Durable and lightweight construction for easy portability.\n- Advanced technology that ensures efficient and reliable operation.\n- Multiple functions and modes to cater to various tasks and preferences.\n- User-friendly interface with intuitive controls for effortless operation.\n- Wide compatibility with other devices and accessories for enhanced versatility.\n- Long-lasting battery life to keep you productive throughout the day.\n\nProduct X is the perfect choice for anyone seeking a reliable and efficient solution. Its exceptional quality and performance make it a must-have for every modern individual. Experience the convenience and effectiveness of Product X and elevate your daily activities to new heights.\n\n",
      img: "assets/images/iphone12.png",
      agencyName: "INWI", qte: 100, price: 1000);
  list.add(list2);

  var list5 =
  BankingDeliveryModel(name: "Water Filtration Dispenser",
      description: "Product Name: Product X\nDescription: \nProduct X is a high-quality and versatile product designed to meet your everyday needs. With its sleek design and advanced features, it provides exceptional performance and convenience. Whether you're using it at home or on the go, Product X delivers outstanding results.\n\nKey Features:\n- Durable and lightweight construction for easy portability.\n- Advanced technology that ensures efficient and reliable operation.\n- Multiple functions and modes to cater to various tasks and preferences.\n- User-friendly interface with intuitive controls for effortless operation.\n- Wide compatibility with other devices and accessories for enhanced versatility.\n- Long-lasting battery life to keep you productive throughout the day.\n\nProduct X is the perfect choice for anyone seeking a reliable and efficient solution. Its exceptional quality and performance make it a must-have for every modern individual. Experience the convenience and effectiveness of Product X and elevate your daily activities to new heights.\n\n",
      img: "assets/images/filterWater.png",
      agencyName: "Lydec", qte: 100, price: 1000);
  list.add(list5);

  var list9 =
  BankingDeliveryModel(name: "Samsung S23 Ultra",
      img: "assets/images/samsungS23.png",
      description: "Product Name: Product X\nDescription: \nProduct X is a high-quality and versatile product designed to meet your everyday needs. With its sleek design and advanced features, it provides exceptional performance and convenience. Whether you're using it at home or on the go, Product X delivers outstanding results.\n\nKey Features:\n- Durable and lightweight construction for easy portability.\n- Advanced technology that ensures efficient and reliable operation.\n- Multiple functions and modes to cater to various tasks and preferences.\n- User-friendly interface with intuitive controls for effortless operation.\n- Wide compatibility with other devices and accessories for enhanced versatility.\n- Long-lasting battery life to keep you productive throughout the day.\n\nProduct X is the perfect choice for anyone seeking a reliable and efficient solution. Its exceptional quality and performance make it a must-have for every modern individual. Experience the convenience and effectiveness of Product X and elevate your daily activities to new heights.\n\n",
      agencyName: "IAM", qte: 100, price: 1000);
  list.add(list9);

  var list3 = BankingDeliveryModel(
      name: "Economic light",
      description: "Product Name: Product X\nDescription: \nProduct X is a high-quality and versatile product designed to meet your everyday needs. With its sleek design and advanced features, it provides exceptional performance and convenience. Whether you're using it at home or on the go, Product X delivers outstanding results.\n\nKey Features:\n- Durable and lightweight construction for easy portability.\n- Advanced technology that ensures efficient and reliable operation.\n- Multiple functions and modes to cater to various tasks and preferences.\n- User-friendly interface with intuitive controls for effortless operation.\n- Wide compatibility with other devices and accessories for enhanced versatility.\n- Long-lasting battery life to keep you productive throughout the day.\n\nProduct X is the perfect choice for anyone seeking a reliable and efficient solution. Its exceptional quality and performance make it a must-have for every modern individual. Experience the convenience and effectiveness of Product X and elevate your daily activities to new heights.\n\n",
      img: "assets/images/bulbeconomic.png",
      agencyName: "Lydec"
      , qte: 100, price: 1000
  );
  list.add(list3);
  var list4 = BankingDeliveryModel(
      name: "Water Filtration Dispenser",
      description: "Product Name: Product X\nDescription: \nProduct X is a high-quality and versatile product designed to meet your everyday needs. With its sleek design and advanced features, it provides exceptional performance and convenience. Whether you're using it at home or on the go, Product X delivers outstanding results.\n\nKey Features:\n- Durable and lightweight construction for easy portability.\n- Advanced technology that ensures efficient and reliable operation.\n- Multiple functions and modes to cater to various tasks and preferences.\n- User-friendly interface with intuitive controls for effortless operation.\n- Wide compatibility with other devices and accessories for enhanced versatility.\n- Long-lasting battery life to keep you productive throughout the day.\n\nProduct X is the perfect choice for anyone seeking a reliable and efficient solution. Its exceptional quality and performance make it a must-have for every modern individual. Experience the convenience and effectiveness of Product X and elevate your daily activities to new heights.\n\n",
      img: "assets/images/filterWater2.png",
      agencyName: "Redal"
      , qte: 100, price: 1000
  );
  list.add(list4);

  var list6 = BankingDeliveryModel(
      name: "Economic Bulb",
      description: "Product Name: Product X\nDescription: \nProduct X is a high-quality and versatile product designed to meet your everyday needs. With its sleek design and advanced features, it provides exceptional performance and convenience. Whether you're using it at home or on the go, Product X delivers outstanding results.\n\nKey Features:\n- Durable and lightweight construction for easy portability.\n- Advanced technology that ensures efficient and reliable operation.\n- Multiple functions and modes to cater to various tasks and preferences.\n- User-friendly interface with intuitive controls for effortless operation.\n- Wide compatibility with other devices and accessories for enhanced versatility.\n- Long-lasting battery life to keep you productive throughout the day.\n\nProduct X is the perfect choice for anyone seeking a reliable and efficient solution. Its exceptional quality and performance make it a must-have for every modern individual. Experience the convenience and effectiveness of Product X and elevate your daily activities to new heights.\n\n",
      img: "assets/images/bulbeconomic2.png",
      agencyName: "Redal"
      , qte: 100, price: 1000
  );
  list.add(list6);

  var list7 = BankingDeliveryModel(
      name: "Samsung s22",
      description: "Product Name: Product X\nDescription: \nProduct X is a high-quality and versatile product designed to meet your everyday needs. With its sleek design and advanced features, it provides exceptional performance and convenience. Whether you're using it at home or on the go, Product X delivers outstanding results.\n\nKey Features:\n- Durable and lightweight construction for easy portability.\n- Advanced technology that ensures efficient and reliable operation.\n- Multiple functions and modes to cater to various tasks and preferences.\n- User-friendly interface with intuitive controls for effortless operation.\n- Wide compatibility with other devices and accessories for enhanced versatility.\n- Long-lasting battery life to keep you productive throughout the day.\n\nProduct X is the perfect choice for anyone seeking a reliable and efficient solution. Its exceptional quality and performance make it a must-have for every modern individual. Experience the convenience and effectiveness of Product X and elevate your daily activities to new heights.\n\n",
      img: "assets/images/samsungS22.png",
      agencyName: "INWI"
      , qte: 100, price: 1000
  );
  list.add(list7);
  var list8 = BankingDeliveryModel(
      name: "Iphone 14 pro max",
      description: "Product Name: Product X\nDescription: \nProduct X is a high-quality and versatile product designed to meet your everyday needs. With its sleek design and advanced features, it provides exceptional performance and convenience. Whether you're using it at home or on the go, Product X delivers outstanding results.\n\nKey Features:\n- Durable and lightweight construction for easy portability.\n- Advanced technology that ensures efficient and reliable operation.\n- Multiple functions and modes to cater to various tasks and preferences.\n- User-friendly interface with intuitive controls for effortless operation.\n- Wide compatibility with other devices and accessories for enhanced versatility.\n- Long-lasting battery life to keep you productive throughout the day.\n\nProduct X is the perfect choice for anyone seeking a reliable and efficient solution. Its exceptional quality and performance make it a must-have for every modern individual. Experience the convenience and effectiveness of Product X and elevate your daily activities to new heights.\n\n",
      img: "assets/images/iphone14.png",
      agencyName: "ORANGE"
      , qte: 100, price: 1000
  );
  list.add(list8);

  return list;
}



//
List<BankingServiceModel> bankingPaymentDetailList() {
  List<BankingServiceModel> list = [];

  var list1 = BankingServiceModel(
      nameService: "Pay New Invoice",
      img: "assets/images/Banking_ic_Voice.png",);
  list.add(list1);

  var list2 = BankingServiceModel(
      nameService: "View Payment History",
      img: "assets/images/Banking_ic_History.png");
  list.add(list2);

  return list;
}
//
// List<BankingCardModel> bankingCardList() {
//   List<BankingCardModel> list = [];
//   var list1 = BankingCardModel(
//       name: "Laura Smith", bank: "The Same Bank", rs: "12,500");
//   list.add(list1);
//
//   var list2 =
//   BankingCardModel(name: "Adam Johnson", bank: "Union Bank", rs: "18,000");
//   list.add(list2);
//
//   var list3 = BankingCardModel(
//       name: "Ana Willson", bank: "Unitied States Bank", rs: "50,000");
//   list.add(list3);
//
//   return list;
// }
//
List<BankingPaymentHistoryModel> bankingHistoryList1() {
  List<BankingPaymentHistoryModel> list = [];

  var list1 = BankingPaymentHistoryModel(
      title: "Payment Invoice # 7783", rs: "-\$200 USD");
  list.add(list1);

  var list2 = BankingPaymentHistoryModel(
      title: "Payment Invoice S1244", rs: "-\$190 USD");
  list.add(list2);

  return list;
}
//
//
// List<BankingHomeModel> bankingHomeList1() {
//   List<BankingHomeModel> list = [];
//   var list1 = BankingHomeModel(
//       title: "Default Account", color: Banking_BalanceColor, bal: "+\$50 USD");
//   list.add(list1);
//
//   var list2 = BankingHomeModel(
//       title: "Adam Johnson", color: Banking_Primary, bal: "-\$20 USD");
//   list.add(list2);
//
//   return list;
// }
//
// List<BankingHomeModel2> bankingHomeList2() {
//   List<BankingHomeModel2> list = [];
//
//   var list1 = BankingHomeModel2(
//       title: "Payment form Paypal",
//       icon: Banking_ic_Paypal,
//       color: Banking_greenLightColor,
//       charge: "+\$50 USD");
//   list.add(list1);
//
//   var list2 = BankingHomeModel2(
//       title: "Mastercard Charge",
//       icon: Banking_ic_MasterCard,
//       color: Banking_Primary,
//       charge: "+\$20 USD");
//   list.add(list2);
//
//   var list3 = BankingHomeModel2(
//       title: "Shopping at WallMart",
//       icon: Banking_ic_Wallet,
//       color: Banking_Primary,
//       charge: "+\$90 USD");
//   list.add(list3);
//
//   return list;
// }

// List<String> countList = [
//   "One",
//   "Two",
//   "Three",
//   "Four",
//   "Five",
//   "Six",
//   "Seven",
//   "Eight",
//   "Nine",
//   "Ten",
// ];
// List<String> selectedCountList = [];


final List<String> categories = [
  'FACTURE',
  'RECHARGE',
  'DONATION',
];


