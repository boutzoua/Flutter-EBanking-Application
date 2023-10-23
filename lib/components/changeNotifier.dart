import 'package:banking/components/banking_model.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

class ProductProvider with ChangeNotifier {
  BankingServiceModel? selectedProduct;

  void setProduct(BankingServiceModel product) {
    selectedProduct = product;
    notifyListeners();
  }
}

class ItemProvider with ChangeNotifier {
  BankingDeliveryModel? selectedItem;

  void setProduct(BankingDeliveryModel item) {
    selectedItem = item;
    notifyListeners();
  }
}