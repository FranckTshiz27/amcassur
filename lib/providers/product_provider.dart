import 'dart:collection';

import 'package:flutter/widgets.dart';

import '../models/product_model.dart';
import '../data/data.dart' as data;

class ProductProvider with ChangeNotifier {
  List<Product> _productForCustomers = data.productForCustomers;
  List<Product> _productForBusiness = data.productForBusiness;

  UnmodifiableListView<Product> get productForCustomers =>
      UnmodifiableListView(_productForCustomers);
  UnmodifiableListView<Product> get productForBusiness =>
      UnmodifiableListView(_productForBusiness);

  Product getProductById(String productId) {
    if (productId.startsWith('p')) {
      return _productForCustomers
          .firstWhere((product) => product.id == productId);
    } else {
      return _productForBusiness
          .firstWhere((product) => product.id == productId);
    }
  }
}
