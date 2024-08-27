import 'package:amcassur/service/auth.service.dart';
import 'package:amcassur/service/user.service.dart';
import 'package:amcassur/shared/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import '../../shared/constants/appcolors.dart';
import '../../shared/widgets/custom_intl_phone_field.dart';

// import 'register/register_phone.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  // final String route;

  static const routName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // late SharedPreferences loginData;
  String phone = '';
  TextEditingController pwdController = TextEditingController();
  // MaskedTextController phoneController =
  //     MaskedTextController(mask: "000-000-000");

  TextEditingController phoneController = TextEditingController();

  String prefix_country = '+242';

  final _formKey = GlobalKey<FormState>();

  bool isSecuredPassword = true;
  bool isLoading = false;

  // String removeDash(String input) {
  //   return input.replaceAll('-', '');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.MAIN_COLOR),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
        centerTitle: true,
      ),
      // backgroundColor: Colors.white,
      body: Container(
        color: AppColors.BACKGROUND_COLOR,
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
                  key: _formKey,
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
                                    searchLabelText: 'Rechercher un pays',
                                    onCountryChanged: (country) {
                                      prefix_country =
                                          '+${country.fullCountryCode}';
                                    },
                                    color: Colors.black,
                                  ),
                                  SizedBox(height: 10),
                                  // MyRawsurTextFormField.MyAmcTextFormField(
                                  //   controller: pwdController,
                                  //   obscureText: isSecuredPassword,
                                  //   labelText: 'Mot de passe',
                                  //   keyboardType: TextInputType.text,
                                  //   prefixIcon: Icon(
                                  //     Icons.lock,
                                  //     color: AppColors.MAIN_COLOR,
                                  //   ),
                                  //   suffixIcon: isSecuredPassword
                                  //       ? Icons.visibility_off
                                  //       : Icons.visibility,
                                  //   onPressed: () {
                                  //     setState(() {
                                  //       isSecuredPassword = !isSecuredPassword;
                                  //     });
                                  //   },
                                  //   autovalidateMode: AutovalidateMode.disabled,
                                  //   validator: Validators.compose([
                                  //     Validators.required(
                                  //         'Entrer un mot de passe')
                                  //   ]),
                                  // ),
                                  SizedBox(height: 40),
                                  ElevatedButton(
                                    // style: MyAmcStyle.amcButtonStyle(context),
                                    onPressed: () async {
                                      String phoneNumber =
                                          phoneController.value.text;
                                      String cleanedNumber =
                                          Util.removeDash(phoneNumber);
                                      if (_formKey.currentState!.validate()) {
                                        if (phoneNumber.length == 9) {
                                          String password =
                                              pwdController.value.text;
                                          setState(() => isLoading = true);
                                          await login(
                                            cleanedNumber,
                                            password,
                                            this.prefix_country,
                                          );
                                        }
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      child: Text(
                                        "SE CONNECTER",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  TextButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         ResetpasswordScreen(),
                                      //   ),
                                      // );
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
                                  // TextButton(
                                  //   onPressed: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => RegisterPhone(),
                                  //       ),
                                  //     );
                                  //   },
                                  //   child: Text(
                                  //     'Pas inscrit ? Créer un compte',
                                  //     style: TextStyle(
                                  //       color: Color.fromRGBO(218, 173, 76, 1),
                                  //       fontSize: 13,
                                  //     ),
                                  //   ),
                                  // )
                                ],
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
      ),
    );
  }

  Future<void> login(
      String phone, String password, String prefix_country) async {
    String response = await AuthService.login(phone, password);

    if (response == "ERROR") {
      AlertController.show(
          "My Rawsur info",
          "Authentification échouée. mot de passe ou numéro de téléphone éroné. Veuillez réessayer.",
          TypeAlert.error);
    } else if (response == "UNAUTHORIZED") {
      AlertController.show(
          "My Rawsur info",
          "Votre mot de passe ou votre numéro de téléphone est incorrect.",
          TypeAlert.error);
    } else if (response == "DESABLE_ACCOUNT") {
      AlertController.show(
          "My Rawsur info",
          "Votre compte n'est pas activé. Pour des raisons administratives, vous devrez vous rendre dans le store RAWSUR le plus proche pour son activation",
          TypeAlert.error);
    } else {
      // SUCCESS
      dynamic resp = await UserService.getProfile(phone);
      // String? pers_moral = await PolicyService.getPersmoral(phone);
    }
    setState(() => isLoading = false);
  }

  // Widget togglePassword() {
  //   return IconButton(
  //     onPressed: () {
  //       setState(() {
  //         isSecuredPassword = !isSecuredPassword;
  //       });
  //     },
  //     icon: isSecuredPassword
  //         ? Icon(Icons.visibility_off)
  //         : Icon(Icons.visibility),
  //   );
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
}
