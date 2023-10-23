import 'package:flutter/cupertino.dart';

class BankingShareInfoModel {
  String icon = "";

  BankingShareInfoModel(this.icon);
}

class BankingQuesAnsModel {
  String ques = "";

  BankingQuesAnsModel(this.ques);
}

class BankingSavingModel {
  String? title = "";
  String? date = "";
  String? rs = "";
  String? interest = "";

  BankingSavingModel({this.title, this.date, this.rs, this.interest});
}

class BankingUnPaidFacture {
  double? id = 0;
  String? clientid = '';
  String? immId = '';
  String? nameService = "";
  String? idService = "";
  String? nameAgency = "";
  String? operationTime = "";
  String? operationStatus = "";
  String? clientUsername = "";
  String? clientEmail = "";
  double? amount = 0.0;
  String? img = '';
  String? category = '';

  BankingUnPaidFacture({this.id,this.immId, this.img, this.category,this.amount,this.clientUsername,this.clientEmail,this.nameService,this.idService,this.clientid,this.nameAgency});
}


class BankingServiceModel {
  String? idService = '';
  String? immId = '';
  String? nameService = "";
  String? nameAgency = "";
  String? img = "";
  String? category = '';

  BankingServiceModel({this.nameService, this.img, this.category,this.idService});
}
class BankingDeliveryModel {
  String? name = "";
  String? img = "";
  String? description = "";
  String? agencyName = '';
  int? qte=0;
  double? price=0.0;

  BankingDeliveryModel({this.name, this.img,this.description, this.agencyName,this.qte,this.price});
}

class BankingCardModel {
  String? name = "";
  String? bank = "";
  String? rs = "";

  BankingCardModel({this.name, this.bank, this.rs});
}

class BankingPaymentHistoryModel {
  String? title = "";
  String? rs = "";

  BankingPaymentHistoryModel({this.title, this.rs});
}

class BankingRateInfoModel {
  String? currency = "";
  String? flag = "";
  String? buy = "";
  String? sell = "";

  BankingRateInfoModel({this.currency, this.flag, this.buy, this.sell});
}

class BankingHomeModel {
  String? name = "";
  String? type;
  String? operationTime = "";
  double? amount = 0.0;

  BankingHomeModel({required this.amount, required this.operationTime, required this.type, required this.name});
}

class BankingLocationModel {
  String? location = "";
  String? m = "";

  BankingLocationModel({this.location, this.m});
}

class BankingHomeModel2 {
  String? title = "";
  String? icon = "";
  Color? color;
  String? charge = "";

  BankingHomeModel2({this.title, this.icon, this.color, this.charge});
}

class BankingUserRegisterModel {
  String? firstName = "";
  String? lastName = "";
  String? username = "";
  String? email = "";
  String? dob = "";
  String? cin = "";
  String? phoneNumber = "";


  BankingUserRegisterModel({this.firstName,this.lastName, this.username, this.email,this.phoneNumber,this.dob, this.cin});
}
class BankingUserLoginModel {
  String? username = "";
  String? password = "";

  BankingUserLoginModel({this.username, this.password});

}
class User {
  final String token;
  final String userType;
  final bool firstLogin;
  final String id;
  final String email;
  final String username;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String fullName;

  User({
    required this.token,
    required this.userType,
    required this.firstLogin,
    required this.id,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.fullName,
  });
}
class Creancier {
  final String? name;
  final String? category;
  Creancier({this.name, this.category});
}

class Facture {
  final int id;
  final double amount;
  final String name;
  final String type;
  final String image;



  Facture({required this.id,required this.name ,required this.image ,required this.type, required this.amount});
}

class Donation {
  final int id;
  final double amount;
  final String name;




  Donation({required this.id,required this.name,required this.amount});
}




