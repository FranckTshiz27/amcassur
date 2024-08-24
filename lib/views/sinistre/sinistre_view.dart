import 'package:amcassur/views/sinistre/widgets/sinistre_step_1.dart';
import 'package:amcassur/views/sinistre/widgets/sinistre_step_2.dart';
import 'package:flutter/material.dart';

import '../../shared/constants/appcolors.dart';
import '../../styles/amc_style.dart';

class SinistreView extends StatefulWidget {
  const SinistreView({super.key});

  static const routName = '/sinistre';

  @override
  State<SinistreView> createState() => _SinistreViewState();
}

class _SinistreViewState extends State<SinistreView> {
  bool isLoading = false;
  bool isBtnVisible = false;

  int currentStep = 0;
  int stepToConfirm = 0;

  onStepContinue() async {
    if (currentStep < 1) {
      setState(() {
        currentStep++;
      });
    }

    if (stepToConfirm == 1) {
      // await onSubmit();

      print('ON SUBMIT');
    }
    print({stepToConfirm, currentStep});
    stepToConfirm = 1;
  }

  onStepCancel() {
    print('TEST');
    // if (currentStep == 1) {
    //   stepToConfirm = currentStep;
    // } else {
    //   stepToConfirm--;
    // }

    if (currentStep > 0) {
      setState(() {
        currentStep = 0;
        stepToConfirm = 0;
      });
    }
    print({stepToConfirm, currentStep});
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Widget controlsBuilder(context, details) {
    double r = currentStep == 1 ? 0.30 : 0.55;
    return Container(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * r),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .020),
      child: Row(
        children: [
          currentStep == 1
              ? Expanded(
                  child: ElevatedButton(
                    // style: MyAmcStyle.amcButtonStyle(context),
                    onPressed: details.onStepCancel,
                    child: Text(
                      "Retour",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Text(''),
          currentStep == 1 ? SizedBox(width: 10.0) : Text(''),
          Expanded(
            child: ElevatedButton(
              // style: MyAmcStyle.amcButtonStyle(context),
              onPressed: details.onStepContinue,
              child: Text(
                currentStep >= 1 ? 'Terminer' : 'Suivant',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SINISTRE',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: AppColors.MAIN_COLOR,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.MAIN_COLOR,
                backgroundColor: Colors.grey,
              ),
            )
          : Container(
              child: Stepper(
                type: StepperType.horizontal,
                physics: ClampingScrollPhysics(),
                currentStep: currentStep,
                onStepContinue: onStepContinue,
                onStepCancel: onStepCancel,
                onStepTapped: onStepTapped,
                controlsBuilder: controlsBuilder,
                steps: [
                  Step(
                    title: Text('Etape 1'),
                    content: SinistreStep1(),
                    isActive: currentStep >= 0,
                    state: currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: Text('Etape 2'),
                    content: SinistreStep2(),
                    // content: RawsurLoader(),
                    isActive: currentStep >= 1,
                    state: currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
    );
  }
}
