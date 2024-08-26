import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/service/otp.service.dart';
import 'package:amcassur/shared/utils/string_util.dart';
import 'package:amcassur/shared/widgets/amc_loader.dart';
import 'package:amcassur/shared/widgets/custom_intl_phone_field.dart';
import 'package:amcassur/shared/widgets/custom_text_form_field.dart';
import 'package:amcassur/styles/amc_style.dart';
import 'package:amcassur/views/auth/register/widgets/otp.screen.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ResetpasswordScreen extends StatefulWidget {
  ResetpasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ResetpasswordScreen> createState() => _ResetpasswordScreenState();
}

class _ResetpasswordScreenState extends State<ResetpasswordScreen> {
  bool isLoading = false;
  double width = 145;
  double height = 45;
  String code = "";

  bool isSecuredPassword = true;
  bool isSecuredPasswordConfirm = true;

  late String PREVIEW_WIDGET = "RESET_PASSWORD";
  String prefix_country = '+243';

  final _ressetPwKey = GlobalKey<FormState>();

  MaskedTextController phoneController =
      MaskedTextController(mask: "000-000-000");
  TextEditingController pwdController = TextEditingController();
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
        // decoration: const BoxDecoration(gradient: AppColors.APP_SCREENS),
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 100),
                child: Column(
                  children: [
                    SizedBox(height: 0),
                    CircleAvatar(
                      child: Icon(
                        Icons.lock_person_outlined,
                        size: 50,
                      ),
                      radius: 45,
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Text(
                        'Veuillez renseigner ci-dessous votre numéro de téléphone attaché à votre compte MyRawsur et un code vous sera envoyé par sms pour une validation.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.WHITE,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Form(
                      key: _ressetPwKey,
                      child: Column(
                        children: [
                          CustomIntlPhoneField(
                            controller: phoneController,
                            labelText: "Téléphone",
                            color: AppColors.WHITE,
                            searchLabelText: 'Rechercher un pays',
                            onCountryChanged: (country) {
                              prefix_country = '+${country.fullCountryCode}';
                            },
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
                              Validators.required('Mot de passe obligatoire'),
                              Validators.minLength(8,
                                  'Le mot de passe doit avoir au moins 8 caractères'),
                              Validators.patternString(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*]).{8,}$',
                                  'Entrer un mot de passe contenant en même temps: \n\n - Une lettre miniscule\n - Une lettre majuscule\n - Un chiffre\nEt un des caractères spécialiaux suivant  [ !@#\$&* ]')
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
                              Validators.required('Mot de passe obligatoire'),
                              Validators.minLength(8,
                                  'Le mot de passe doit avoir au moins 8 caractères'),
                              Validators.patternString(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*]).{8,}$',
                                  'Entrer un mot de passe contenant en même temps: \n\n - Une lettre miniscule\n - Une lettre majuscule\n - Un chiffre\nEt un des caractères spécialiaux suivant  [ !@#\$&* ]')
                            ]),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            style: MyRawsurStyle.myCustomButtonStyle,
                            onPressed: () async {
                              if (_ressetPwKey.currentState!.validate()) {
                                String username = StringUtil.removeDash(
                                  phoneController.value.text,
                                );
                                String pwd = pwdController.value.text.trim();
                                String pwd_confirm =
                                    pwdConfirmController.value.text.trim();

                                if (pwd == pwd_confirm) {
                                  Map<String, dynamic> payload = {
                                    "username": username,
                                    "password": pwd,
                                  };

                                  await sendOtp(payload, this.prefix_country);
                                } else {
                                  // showSnackbar(
                                  //   "My Rawsur info",
                                  //   "\nLes deux mots de passe ne sont pas identiques.",
                                  // );
                                  // return;
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: isLoading
                                  ? AmcLoader(color: AppColors.BLUE)
                                  : Text(
                                      "Réinitialiser".toUpperCase(),
                                      style: TextStyle(
                                        color: AppColors.WHITE,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
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
            // DropdownAlert(),
          ],
        ),
      ),
    );
  }

  Future<void> resendOtp(String username) async {
    var dtoSendOtp = {"username": username};
    print('dtoSendOtp : $dtoSendOtp');
    await OtpService.sendOTP(dtoSendOtp);
  }

  // void showSnackbar(String title, String message) {
  //   AlertController.show(title, message, TypeAlert.error);
  // }

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
              preview_widget: this.PREVIEW_WIDGET),
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Home()),
        // );
        // return;
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Home()),
        // );
        // return;
      }
    } else {
      setState(() => isLoading = false);
      // showSnackbar(
      //   "Echec de la création de l'utilisateur",
      //   "Merci de réesayer",
      // );
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
}
