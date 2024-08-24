import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../shared/constants/appcolors.dart';
import 'product_details.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: AssetImage(product.imageProfil),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.TEXT_COLOR.withOpacity(.5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          InkWell(
            onTap: () {
              print('TEST');
              Navigator.pushNamed(
                context,
                ProductDetail.routName,
                arguments: {'productId': product.id},
              );
            },
            child: Center(
              child: Text(
                product.name,
                style: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
