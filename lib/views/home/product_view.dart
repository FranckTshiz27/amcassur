import 'package:amcassur/views/home/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:amcassur/models/product_model.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../shared/constants/appcolors.dart';
import '../../shared/widgets/drawer.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  static const routName = '/product';

  @override
  Widget build(BuildContext context) {
    List<Product> productForCustomers =
        Provider.of<ProductProvider>(context, listen: false)
            .productForCustomers;
    List<Product> productForBusiness =
        Provider.of<ProductProvider>(context, listen: false).productForBusiness;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOS PRODUITS',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: AppColors.MAIN_COLOR,
      ),
      drawer: AmcDrawer(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              ProductList(products: productForCustomers, title: 'PARTICULIER'),
              SizedBox(height: 10),
              ProductList(products: productForBusiness, title: 'ENTREPRISE'),
            ],
          ),
        ),
      ),
    );
  }
}
