import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import '../../../models/product_model.dart';
import '../../../providers/product_provider.dart';
import '../../../shared/constants/appcolors.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  static const routName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final String productId = (ModalRoute.of(context)!.settings.arguments
        as Map<String, String?>)['productId'] as String;

    final Product product = Provider.of<ProductProvider>(context, listen: false)
        .getProductById(productId);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black38,
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                product.description,
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SpeedDial(
            animatedIcon: AnimatedIcons.add_event,
            backgroundColor: AppColors.SECOND_COLOR,
            children: [
              SpeedDialChild(
                label: 'Condition générale',
                backgroundColor: AppColors.SECOND_COLOR,
                child: Icon(Icons.picture_as_pdf_sharp, color: Colors.white),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
