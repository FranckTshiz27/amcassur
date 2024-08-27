import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/configs/preference.dart';
import 'package:amcassur/configs/preferencekeys.dart';
import 'package:amcassur/service/otp.service.dart';
import 'package:amcassur/shared/widgets/amc_loader.dart';
import 'package:amcassur/shared/widgets/custom_text_form_field.dart';
import 'package:amcassur/styles/amc_style.dart';
import 'package:amcassur/views/auth/register/widgets/otp.screen.dart';
import 'package:amcassur/views/home/home_view.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';

import '../../configs/constants.dart';

class UpdatepasswordScreen extends StatefulWidget {
  UpdatepasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdatepasswordScreen> createState() => _UpdatepasswordScreenState();
}

class _UpdatepasswordScreenState extends State<UpdatepasswordScreen> {
  bool isLoading = false;
  double width = 145;
  double height = 45;
  String code = "";

  bool isSecuredPassword = true;
  bool isSecuredPasswordConfirm = true;
  bool old_isSecuredPassword = true;

  late String PREVIEW_WIDGET = "CHANGE_PASSWORD";
  String prefix_country = '';

  String regexError =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*]).{8,}$';
  String errorMessage =
      'Le mot de passe doit avoir :\n - 8 caractères au minimum\n - au moins une lettre majuscule\n - au moins un chiffre\n - au moins un caractère spécialial';

  final _updatePwKey = GlobalKey<FormState>();

  TextEditingController pwdController = TextEditingController();
  TextEditingController old_pwdController = TextEditingController();
  TextEditingController pwdConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var phone_number = Preferences.get(PreferenceKeys.PHONE_NUMBER);
    var prefix_country = Preferences.get(PreferenceKeys.PREFIX_COUNTRY);
    var password = Preferences.get(PreferenceKeys.PASSWORD);

    String? phone = phone_number;

    phone = phone?.replaceRange(2, 3, "*");
    phone = phone?.replaceRange(3, 4, "*");
    phone = phone?.replaceRange(4, 5, "*");
    phone = phone?.replaceRange(5, 6, "*");
    phone = phone?.replaceRange(6, 7, "*");

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.only(left: 25, right: 25),
        // decoration: const BoxDecoration(gradient: AppColors.APP_SCREENS),
        child: Stack(children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  CircleAvatar(
                    child: Icon(
                      Icons.lock_person_outlined,
                      size: 50,
                    ),
                    radius: 45,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Changement de mot de passe',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.DARK_BLUE,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Text(
                      "Veuillez renseigner ci-dessous votre ancien mot de passe et le nouveau et un code vous sera envoyé par sms au ${prefix_country}" +
                          "${phone} pour une validation. : ",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.DARK_BLUE),
                    ),
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: _updatePwKey,
                    child: Column(
                      children: [
                        MyRawsurTextFormField(
                          controller: old_pwdController,
                          obscureText: old_isSecuredPassword,
                          labelText: 'Votre ancien mot de passe',
                          color: AppColors.DARK_BLUE,
                          keyboardType: TextInputType.text,
                          suffixIcon: old_isSecuredPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onPressed: () {
                            setState(() {
                              old_isSecuredPassword = !old_isSecuredPassword;
                            });
                          },
                          autovalidateMode: AutovalidateMode.disabled,
                          validator: Validators.compose([
                            Validators.required('Mot de passe obligatoire'),
                            Validators.patternString(regexError, errorMessage)
                          ]),
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          controller: pwdController,
                          obscureText: isSecuredPassword,
                          labelText: 'Mot de passe',
                          color: AppColors.DARK_BLUE,
                          keyboardType: TextInputType.text,
                          suffixIcon: isSecuredPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onPressed: () {
                            setState(() {
                              isSecuredPassword = !isSecuredPassword;
                            });
                          },
                          autovalidateMode: AutovalidateMode.disabled,
                          validator: Validators.compose([
                            Validators.required('Champs obligatoire'),
                            Validators.patternString(regexError, errorMessage)
                          ]),
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          controller: pwdConfirmController,
                          obscureText: isSecuredPasswordConfirm,
                          labelText: 'Confirmer le mot de passe',
                          color: AppColors.DARK_BLUE,
                          keyboardType: TextInputType.text,
                          suffixIcon: isSecuredPasswordConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onPressed: () {
                            setState(() {
                              isSecuredPasswordConfirm =
                                  !isSecuredPasswordConfirm;
                            });
                          },
                          autovalidateMode: AutovalidateMode.disabled,
                          validator: Validators.compose([
                            Validators.required('Champs obligatoire'),
                            Validators.patternString(regexError, errorMessage),
                            (String? value) {
                              bool test = pwdController.text ==
                                  pwdConfirmController.text;
                              return test
                                  ? null
                                  : 'mot de passe non identique au précedent';
                            }
                          ]),
                        ),
                        SizedBox(height: 50),
                        ElevatedButton(
                          style: MyRawsurStyle.myCustomButtonStyle,
                          onPressed: () async {
                            if (password !=
                                old_pwdController.value.text.trim()) {
                              showSnackbar(
                                "My Rawsur info",
                                "\nVotre ancien mot de passe est incorrect.",
                              );
                              return;
                            }

                            if (_updatePwKey.currentState!.validate()) {
                              String pwd = pwdController.value.text.trim();

                              Map<String, dynamic> payload = {
                                "username": phone_number,
                                "password": pwd,
                              };

                              await sendOtp(payload, prefix_country!);
                            }
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: isLoading
                                ? AmcLoader(color: AppColors.BLUE)
                                : Text(
                                    "Changer le mot de passe".toUpperCase(),
                                    style: TextStyle(
                                      color: AppColors.WHITE,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              .04,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          DropdownAlert(),
        ]),
      ),
    );
  }

  Future<void> resendOtp(String username) async {
    var dtoSendOtp = {"username": username};
    print('dtoSendOtp : $dtoSendOtp');
    await OtpService.sendOTP(dtoSendOtp);
  }

  void showSnackbar(String title, String message) {
    AlertController.show(title, message, TypeAlert.error);
  }

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          isSecuredPassword = !isSecuredPassword;
        });
      },
      icon: isSecuredPassword
          ? Icon(Icons.visibility_off)
          : Icon(Icons.visibility),
    );
  }

  Future<void> sendOtp(
      Map<String, dynamic> payload, String prefix_country) async {
    setState(() => isLoading = true);
    var dtoSendOtp = {
      "username": payload['username'],
      "prefix_country": prefix_country
    };
    String status = await OtpService.sendOTP(dtoSendOtp);
    // Code 200
    if (status == 'SUCCESS') {
      setState(() => isLoading = false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            payload: payload,
            prefix_country: prefix_country,
            preview_widget: this.PREVIEW_WIDGET,
          ),
        ),
      );
    }
    // Erreur 201
    else if (status == 'OFF_SERVICE') {
      setState(() => isLoading = false);

      ArtDialogResponse responseDialg = await ArtSweetAlert.show(
          barrierDismissible: false,
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.warning,
              title: "My Rawsur info",
              text:
                  "Service indisponible pour l'instant\nMerci de réesayer plus tard",
              confirmButtonText: "Ok"));

      if (responseDialg.isTapConfirmButton) {
        // return at home page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
          (route) => false,
        );
        return;
      }
      // Erreur 500
    } else if (status == 'OTP_NOT_SAVE' || status == 'ERROR') {
      setState(() => isLoading = false);

      ArtDialogResponse responseDialg = await ArtSweetAlert.show(
          barrierDismissible: false,
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.warning,
              title: "My Rawsur info",
              text:
                  "Service indisponible pour l'instant\nMerci de réesayer plus tard",
              confirmButtonText: "Ok"));

      if (responseDialg.isTapConfirmButton) {
        // return at home page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
          (route) => false,
        );
        return;
      }
    } else {
      setState(() => isLoading = false);
      showSnackbar(
        "Echec de la création de l'utilisateur",
        "Merci de réesayer",
      );
    }
  }

  Widget togglePasswordConfirm() {
    return IconButton(
      onPressed: () {
        setState(() {
          isSecuredPasswordConfirm = !isSecuredPasswordConfirm;
        });
      },
      icon: isSecuredPasswordConfirm
          ? Icon(Icons.visibility_off)
          : Icon(Icons.visibility),
    );
  }

  Widget toggleOldPassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          old_isSecuredPassword = !old_isSecuredPassword;
        });
      },
      icon: old_isSecuredPassword
          ? Icon(Icons.visibility_off)
          : Icon(Icons.visibility),
    );
  }
}
