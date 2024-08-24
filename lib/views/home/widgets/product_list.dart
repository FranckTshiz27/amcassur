import 'package:flutter/material.dart';
import 'package:amcassur/views/home/widgets/produit_card.dart';

import '../../../models/product_model.dart';
import '../../../shared/constants/appcolors.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.products, required this.title});
  final List<Product> products;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.SECOND_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: products
              .map(
                (product) => ProductCard(
                  product: product,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
