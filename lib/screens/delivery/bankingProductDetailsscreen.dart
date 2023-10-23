import 'package:banking/components/banking_model.dart';
import 'package:banking/components/changeNotifier.dart';
import 'package:banking/screens/payment/bankingOTPVerficationPayment.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemProvider productProvider = Provider.of<ItemProvider>(context);
    BankingDeliveryModel? selectedProduct = productProvider.selectedItem;
    print(selectedProduct);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  selectedProduct!.img.toString(),
                  height: 200,
                  width: 300,
                ),
                15.height,
                Text(
                  'Product Name: ${selectedProduct?.name}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Product Description: ${selectedProduct.description}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                10.height,
                Text(
                  'Quantity: ${selectedProduct.qte}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Price: ${selectedProduct.price}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirmation'),
                        content: Text('Are you sure you want to proceed with the payment?'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OTPVerificationPaymentPage(),
                                ),
                              );
                            },
                            child: Text('Pay'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              finish(context);
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Pay Now'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
