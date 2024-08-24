import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/providers/register_data.dart';
import 'package:amcassur/providers/register_data_provider.dart';
import 'package:amcassur/service/formatter.dart';
import 'package:amcassur/service/user.service.dart';
import 'package:amcassur/shared/utils/date_utils.dart';
import 'package:amcassur/shared/utils/string_util.dart';
import 'package:amcassur/shared/widgets/amc_loader.dart';
import 'package:amcassur/shared/widgets/custom_alert.dart';
import 'package:amcassur/shared/widgets/custom_intl_phone_field.dart';
import 'package:amcassur/shared/widgets/custom_text_form_field.dart';
import 'package:amcassur/styles/amc_style.dart';
import 'package:amcassur/views/auth/register/login.dart';
import 'package:amcassur/views/auth/register/register_step2.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class RegisterStep1 extends StatefulWidget {
  RegisterStep1({Key? key}) : super(key: key);

  // late RegisterData rData;

  @override
  State<RegisterStep1> createState() => _RegisterStep1State();
}

class _RegisterStep1State extends State<RegisterStep1> {
  final _register1Key = GlobalKey<FormState>();

  bool isLoading = false;

  String PREVIEW_WIDGET = "REGISTER";
  late RegisterDataProvider rDataProvider;

  @override
  void initState() {
    super.initState();
    // Initialisation du RegisterDataProvider
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    rDataProvider = Provider.of<RegisterDataProvider>(context, listen: false);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => AMCassurDateUtils.styleDatePicker(
        context,
        child,
      ),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        String dateFormated = DateFormat('dd/MM/yyyy').format(pickedDate);
        // widget.rData.dateNaisSouscripteurController.text = dateFormated;
        rDataProvider.dateNaisSouscripteurController.text = dateFormated;
        // date = pickedDate.toLocal();
      });
    }
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
      backgroundColor: AppColors.WHITE,
      body: Container(
        height: double.infinity,
        // decoration: const BoxDecoration(gradient: AppColors.APP_SCREENS),
        child: Center(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _register1Key,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .11),
                    margin: EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyRawsurTextFormField(
                          controller: rDataProvider.lnameController,
                          labelText: 'Nom',
                          color: AppColors.DARK_BLUE,
                          keyboardType: TextInputType.text,
                          // inputFormatters: [RigthTrimFormatter()],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: Validators.compose(
                            [Validators.required("Le nom est obligatoire")],
                          ),
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          controller: rDataProvider.pnameController,
                          labelText: 'Postnom',
                          color: AppColors.DARK_BLUE,
                          keyboardType: TextInputType.text,
                          // inputFormatters: [RigthTrimFormatter()],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          controller: rDataProvider.fnameController,
                          labelText: 'Prénom',
                          color: AppColors.DARK_BLUE,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // inputFormatters: [RigthTrimFormatter()],
                          validator: Validators.compose([
                            Validators.required("Le prénom est obligatoire"),
                          ]),
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          controller: rDataProvider.codeClientController,
                          labelText: 'Code client',
                          color: AppColors.DARK_BLUE,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          controller: rDataProvider.emailController,
                          labelText: 'Email',
                          color: AppColors.DARK_BLUE,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(70),
                            // RigthTrimFormatter()
                          ],
                          validator: Validators.compose([
                            Validators.email(
                              'Votre adresse e-mail est incorrecte',
                            )
                          ]),
                        ),
                        SizedBox(height: 10),
                        CustomIntlPhoneField(
                          controller: rDataProvider.phoneController,
                          labelText: "Téléphone",
                          //  color: AppColors.DARK_BLUE,
                          searchLabelText: 'Rechercher un pays',
                          onCountryChanged: (country) {
                            rDataProvider.prefix_country =
                                '+${country.fullCountryCode}';
                          },
                          color: Colors.black,
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          maxLines: 2,
                          controller: rDataProvider.adressController,
                          labelText: 'Adresse',
                          color: AppColors.DARK_BLUE,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: Validators.compose([
                            Validators.required("L'adresse est obligatoire")
                          ]),
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          controller: rDataProvider.lieuNaissController,
                          labelText: 'Lieu de naissance',
                          color: AppColors.DARK_BLUE,
                          keyboardType: TextInputType.text,
                          inputFormatters: [RigthTrimFormatter()],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: Validators.compose([
                            Validators.required(
                              "Lieu de naissance est obligatoire",
                            )
                          ]),
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          controller:
                              rDataProvider.dateNaisSouscripteurController,
                          labelText: 'Date de naissance',
                          color: AppColors.DARK_BLUE,
                          keyboardType: TextInputType.datetime,
                          suffixIcon: Icons.calendar_month,
                          validator: rDataProvider.validateDateField(),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          style: MyRawsurStyle.myCustomButtonStyle,
                          onPressed: () async {
                            String phone = rDataProvider.phoneController.text;
                            phone = StringUtil.removeDash(phone);
                            if (_register1Key.currentState!.validate()) {
                              if (phone.length != 9) {
                                await rawsurShowCustomDialog(
                                  context: context,
                                  type: ArtSweetAlertType.danger,
                                  text:
                                      'Saisissez un numero de téléphone valide',
                                  confirmButtonText: "Ok",
                                );
                                return;
                              }
                              setState(() => isLoading = true);
                              // dynamic response = '';
                              dynamic response =
                                  await UserService.getUserByUsername(
                                phone,
                              );

                              setState(() => isLoading = false);
                              if (response == '') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterStep2(),
                                  ),
                                );
                              } else {
                                await rawsurShowCustomDialog(
                                  context: context,
                                  text:
                                      'Un utilisateur avec le numero +243$phone existe déjà',
                                  type: ArtSweetAlertType.danger,
                                  confirmButtonText: "Ok",
                                  onConfirm: () {
                                    return;
                                  },
                                );
                              }
                            }
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => RegisterStep2(),
                            //   ),
                            // );
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: isLoading
                                ? AmcLoader(color: AppColors.BLUE)
                                : Text(
                                    'Suivant',
                                    style: TextStyle(
                                      color: AppColors.WHITE,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                          ),
                        ),

                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LoginScreen(route: "profile"),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Se connecter',
                                    style: TextStyle(
                                      color: Color.fromRGBO(218, 173, 76, 1),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // CustomRow(
                        //   selectedIndex: 0,
                        //   count: 3,
                        //   color: AppColors.WHITE,
                        // ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // DropdownAlert()
            ],
          ),
        ),
      ),
    );
  }
}

// String? checkIfCaracteSpecial(String text, String name) {
//   String? value = null;
//   List<String> specialCaracteres = Data.specialCaracteres;
//   // print(specialCaracteres);
//   List<String> textArray = text.split("");
//   for (var i = 0; i < textArray.length; i++) {
//     String item = textArray[i];
//     if (specialCaracteres.contains(item)) {
//       value = "Pas de caractère special pour le $name";
//       return value;
//     }
//   }
//   return value;
// }

String? checkIfEqual(String pwd, String pwdConfirm) {
  String? value = null;
  if (pwd != pwdConfirm) {
    value = "Les deux mots de passe ne sont pas identiques.";
    return value;
  }
  return value;
}
