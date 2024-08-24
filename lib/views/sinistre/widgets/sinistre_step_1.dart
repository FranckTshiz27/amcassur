import 'package:flutter/material.dart';

import '../../../models/risque_model.dart';
import '../../../shared/constants/appcolors.dart';
import '../../../shared/widgets/custom_text_form_field.dart';

class SinistreStep1 extends StatefulWidget {
  const SinistreStep1({super.key});

  @override
  State<SinistreStep1> createState() => _SinistreStep1State();
}

class _SinistreStep1State extends State<SinistreStep1> {
  bool isLoading = false;
  List<Risque> risques = [];
  List<Risque> risquesTempon = [];
  TextEditingController searchMatriculeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            height: 250,
            width: 200,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.MAIN_COLOR,
                backgroundColor: Colors.grey,
              ),
            ),
          )
        : Column(
            children: [
              Row(
                children: [
                  // Expanded(
                  //   child: MyRawsurTextFormField.MyAmcTextFormField(
                  //     controller: searchMatriculeController,
                  //     labelText: 'Taper un numero matricule',
                  //     keyboardType: TextInputType.text,
                  //     prefixIcon: Icon(
                  //       Icons.search_sharp,
                  //       color: AppColors.MAIN_COLOR,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        AppColors.MAIN_COLOR,
                      ), // Change the color here
                      foregroundColor: WidgetStateProperty.all(
                        AppColors.MAIN_COLOR,
                      ),
                      textStyle: WidgetStateProperty.all(
                        TextStyle(
                          color: AppColors.MAIN_COLOR,
                        ),
                      ),
                      elevation: WidgetStateProperty.all(2),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Icon(
                        Icons.search,
                        color: AppColors.BACKGROUND_COLOR,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
