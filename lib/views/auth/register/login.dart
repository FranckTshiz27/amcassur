import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/configs/preference.dart';
import 'package:amcassur/configs/preferencekeys.dart';
import 'package:amcassur/service/auth.service.dart';
import 'package:amcassur/shared/utils/util.dart';
import 'package:amcassur/shared/widgets/amc_loader.dart';
import 'package:amcassur/shared/widgets/custom_alert.dart';
import 'package:amcassur/shared/widgets/custom_intl_phone_field.dart';
import 'package:amcassur/shared/widgets/custom_text_form_field.dart';
import 'package:amcassur/styles/amc_style.dart';
import 'package:amcassur/views/auth/register/register_step1.dart';
import 'package:amcassur/views/auth/register/widgets/resetpassword.screen.dart';
import 'package:amcassur/views/profile.dart';
import 'package:amcassur/views/sinistre/sinistre_view.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.route}) : super(key: key);
  final String route;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences loginData;
  String phone = '';
  TextEditingController pwdController = TextEditingController();
  MaskedTextController phoneController =
      MaskedTextController(mask: "000-000-000");

  // TextEditingController phoneController = TextEditingController();

  String prefix_country = '+243';

  final _loginKey = GlobalKey<FormState>();

  bool isSecuredPassword = true;
  bool isLoading = false;

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
      // backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        // decoration: const BoxDecoration(gradient: AppColors.APP_SCREENS)
        child: Center(
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 150),
                    child: Image.asset(
                      'assets/icons/amc-logo.PNG',
                      width: 120,
                      height: 120,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Form(
                  key: _loginKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.41,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 25, right: 25),
                              child: Column(
                                children: [
                                  CustomIntlPhoneField(
                                    controller: phoneController,
                                    labelText: "Téléphone",
                                    color: AppColors.DARK_BLUE,
                                    searchLabelText: 'Rechercher un pays',
                                    onCountryChanged: (country) {
                                      prefix_country =
                                          '+${country.fullCountryCode}';
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
                                      Validators.required(
                                          'Entrer un mot de passe')
                                    ]),
                                  ),
                                  SizedBox(height: 40),
                                  ElevatedButton(
                                    style: MyRawsurStyle.myCustomButtonStyle,
                                    onPressed: () async {
                                      String phoneNumber =
                                          phoneController.value.text;
                                      String cleanedNumber =
                                          Util.removeDash(phoneNumber);
                                      if (_loginKey.currentState!.validate()) {
                                        if (cleanedNumber.length == 9) {
                                          String password =
                                              pwdController.value.text;
                                          setState(() => isLoading = true);
                                          await login(
                                            cleanedNumber,
                                            password,
                                            this.prefix_country,
                                          );
                                        } else {
                                          await rawsurShowCustomDialog(
                                            context: context,
                                            type: ArtSweetAlertType.danger,
                                            text:
                                                'Saisissez un numero de téléphone valide',
                                            confirmButtonText: "Ok",
                                          );
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      child: isLoading
                                          ? AmcLoader(
                                              color: AppColors.BLUE,
                                            )
                                          : Text(
                                              "Connectez-vous".toUpperCase(),
                                              style: TextStyle(
                                                color: AppColors.WHITE,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ResetpasswordScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Mot de passe oublié ?',
                                      style: TextStyle(
                                        // decoration: TextDecoration.underline,
                                        color:
                                            Color.fromARGB(255, 117, 123, 138),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 70),
                      Container(
                        width: double.infinity,
                        height: 140,
                        padding: EdgeInsets.only(bottom: 80),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(30, 68, 132, 1),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // RegisterData rData = RegisterData();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterStep1(
                                    // rData: rData,
                                    ),
                              ),
                            );
                          },
                          child: Text(
                            'Pas inscrit ? Créer un compte',
                            style: TextStyle(
                              color: Color.fromRGBO(218, 173, 76, 1),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DropdownAlert(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(
      String phone, String password, String prefix_country) async {
    String response = await AuthService.login(phone, password);
    // final AutosurFormData autosurFormData = AutosurFormData();
    // final KimiaFormData kimiaFormData = KimiaFormData();
    // final GosurFormData gosurFormData = GosurFormData();
    // final EducasurFormData educasurFormData = EducasurFormData();
    print(phone);
    if (response == "ERROR") {
      AlertController.show(
          "My Amcassur info",
          "Authentification échouée. mot de passe ou numéro de téléphone éroné. Veuillez réessayer.",
          TypeAlert.error);
    } else if (response == "UNAUTHORIZED") {
      AlertController.show(
          "My Amcassur info",
          "Votre mot de passe ou votre numéro de téléphone est incorrect.",
          TypeAlert.error);
    } else if (response == "DESABLE_ACCOUNT") {
      AlertController.show(
          "My Amcassur info",
          "Votre compte n'est pas activé. Pour des raisons administratives, vous devrez vous rendre dans le store RAWSUR le plus proche pour son activation",
          TypeAlert.error);
    } else {
      // SUCCESS

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SinistreView()),
      );

      // dynamic resp = await UserService.getProfile(phone);
      // String? pers_moral = await PolicyService.getPersmoral(phone);
      // if (pers_moral != null) {
      //   await Preferences.set(PreferenceKeys.PERSMORAL, pers_moral);
      // }

      await Preferences.set(PreferenceKeys.PHONE_NUMBER, phone);
      await Preferences.set(PreferenceKeys.PREFIX_COUNTRY, prefix_country);

      switch (widget.route) {
        case "sinistre":
          // Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SinistreView()),
          );
          break;
        case "profile":
          // Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
          break;
      }

      // switch (widget.route) {
      //   case 'sinistre':
      //     // Navigator.pop(context);
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(builder: (context) => SinistreScreen()),
      //     );
      //     break;
      //   case 'police':
      //     // Navigator.pop(context);
      //     Navigator.pushReplacement(
      //       context,
      //       // MaterialPageRoute(builder: (context) => MyPoliciesScreens()),
      //       MaterialPageRoute(builder: (context) => TypePolicyScreen()),
      //     );
      //     break;
      //   case 'profile':
      //     // Navigator.pop(context);
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(builder: (context) => ProfileScreen()),
      //     );
      //     break;
      //   case 'souscription':
      //     // Navigator.pop(context);
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(builder: (context) => Souscription()),
      //     );
      //     break;
      //   case 'educasur':
      //     // Navigator.pop(context);
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => SouscriptionEducasur1(
      //           educasurFormData: educasurFormData,
      //         ),
      //       ),
      //     );
      //     break;
      //   case 'kimia':
      //     // Navigator.pop(context);
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => SouscriptionVie(
      //           kimiaFormData: kimiaFormData,
      //         ),
      //       ),
      //     );
      //     break;
      //   case 'securis':
      //     // Navigator.pop(context);
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => SouscriptionVie(
      //           kimiaFormData: kimiaFormData,
      //         ),
      //       ),
      //     );
      //     break;
      //   case 'autosur':
      //     // Navigator.pop(context);
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => SouscriptionAutosur(
      //           autosurFormData: autosurFormData,
      //         ),
      //       ),
      //     );
      //     break;
      //   case 'gosur':
      //     // Navigator.pop(context);
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => SouscriptionGosur1(
      //           gosurFormData: gosurFormData,
      //         ),
      //       ),
      //     );
      //     break;
      //   default:
      //     Navigator.pop(context);
      //   // Navigator.pushReplacement(
      //   //   context,
      //   //   MaterialPageRoute(builder: (context) => Home()),
      //   // );
      // }
    }
    setState(() => isLoading = false);
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
}
