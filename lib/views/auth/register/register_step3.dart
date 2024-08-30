import 'dart:convert';

import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/enum/type_identity_doc.dart';
import 'package:amcassur/providers/register_data_provider.dart';
import 'package:amcassur/service/otp.service.dart';
import 'package:amcassur/shared/utils/date_utils.dart';
import 'package:amcassur/shared/utils/fileUtil.dart';
import 'package:amcassur/shared/utils/string_util.dart';
import 'package:amcassur/shared/widgets/amc_loader.dart';
import 'package:amcassur/shared/widgets/custom_alert.dart';
import 'package:amcassur/shared/widgets/custom_text_form_field.dart';
import 'package:amcassur/styles/amc_style.dart';
import 'package:amcassur/views/auth/register/widgets/otp.screen.dart';
import 'package:amcassur/views/auth/register/widgets/resetpassword.screen.dart';
import 'package:amcassur/views/home/home_view.dart';
import 'package:amcassur/views/home/product_view.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'widgets/card_identity.dart';

class RegisterStep3 extends StatefulWidget {
  const RegisterStep3({super.key});

  @override
  State<RegisterStep3> createState() => _RegisterStep3State();
}

class _RegisterStep3State extends State<RegisterStep3>
    with TickerProviderStateMixin {
  late RegisterDataProvider rDataProvider;
  String errorMessage = "";
  late TabController _tabController;
  bool isLoading = false;

  final _register3Key = GlobalKey<FormState>();

  String PREVIEW_WIDGET = "REGISTER";

  String getYpeDoc(TypeIdentityDoc typeDoc) {
    switch (typeDoc) {
      case TypeIdentityDoc.passport:
        return 'passport';
      case TypeIdentityDoc.carte_electeur:
        return 'carte_electeur';
      case TypeIdentityDoc.permis_conduire:
        return 'permis_conduire';
      default:
        return 'carte_agent_ordre';
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );

    // rDataProvider = Provider.of<RegisterDataProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    rDataProvider = Provider.of<RegisterDataProvider>(context, listen: false);
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
      // backgroundColor: AppColors.DARK_BLUE,
      body: Container(
        height: double.infinity,
        // decoration: const BoxDecoration(gradient: AppColors.APP_SCREENS),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 25, right: 25),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _register3Key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ajouter votre pièce d'identité",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.DARK_BLUE,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * .05,
                    ),
                  ),
                  SizedBox(height: 20),
                  MyRawsurTextFormField(
                    controller: rDataProvider.numPieceController,
                    labelText: "Numero de pièce d'identité",
                    color: AppColors.DARK_BLUE,
                    keyboardType: TextInputType.text,
                    // inputFormatters: [RigthTrimFormatter()],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: Validators.compose(
                      [Validators.required("Numero obligatoire")],
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    elevation: 4,
                    child: TabBar(
                      controller: _tabController,
                      indicatorWeight: 3.0,
                      indicatorColor: AppColors.DARK_BLUE,
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: AppColors.DARK_BLUE,
                      labelStyle: TextStyle(
                        fontSize: 8,
                        color: AppColors.DARK_BLUE,
                      ),
                      onTap: (index) {
                        // Empêche la sélection des deux derniers onglets
                        print(index);
                        // if (index == 2 || index == 3) {
                        //   // _tabController.index = index - 1;
                        //   _tabController.animateTo(
                        //     index - 1,
                        //   ); // Reste sur l'onglet actuel
                        //   // setState(() {});
                        // }
                      },
                      tabs: [
                        Tab(child: Text("Passeport")),
                        Tab(child: Text("Carte d'électeur")),
                        Tab(child: Text("Permis de conduire")),
                        Tab(child: Text("Carte d'agent de l'ordre")),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.42,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        CardIdentity(
                          index: 0,
                          title: "Passeport",
                          typeDoc: TypeIdentityDoc.passport,
                        ),
                        CardIdentity(
                          index: 1,
                          title: "Carte d'électeur",
                          typeDoc: TypeIdentityDoc.carte_electeur,
                        ),
                        CardIdentity(
                          index: 2,
                          title: "Permis de conduire",
                          typeDoc: TypeIdentityDoc.permis_conduire,
                        ),
                        CardIdentity(
                          index: 3,
                          title: "Carte d'agent de l'ordre",
                          typeDoc: TypeIdentityDoc.carte_agent_ordre,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    style: MyRawsurStyle.myCustomButtonStyle,
                    onPressed: () async {
                      this.errorMessage = "";

                      if (_register3Key.currentState!.validate()) {
                        if (rDataProvider.getIdentityDoc() == null) {
                          await rawsurShowCustomDialog(
                            context: context,
                            type: ArtSweetAlertType.danger,
                            text: "Ajouter une photo de votre pièce d'identité",
                            confirmButtonText: "Ok",
                          );
                          return;
                        }
                        // widget.rData.dateExpPassporController
                        String typeDoc = getYpeDoc(rDataProvider.typeDoc);
                        String dateExp =
                            rDataProvider.dateExpPassporController.text;
                        if (typeDoc == 'passport') {
                          String? validateDateExp =
                              rDataProvider.validateDateExp(dateExp);
                          if (validateDateExp != null) {
                            await rawsurShowCustomDialog(
                              context: context,
                              type: ArtSweetAlertType.warning,
                              text:
                                  "Entrer une date d'expiration de passeport valide",
                              confirmButtonText: "Ok",
                            );
                            return;
                          }
                        }
                        String phone = rDataProvider.phoneController.value.text;
                        String fName =
                            rDataProvider.fnameController.value.text.trim();
                        String pName =
                            rDataProvider.pnameController.value.text.trim();
                        String lastName =
                            rDataProvider.lnameController.value.text.trim();
                        String email =
                            rDataProvider.emailController.value.text.trim();
                        String password =
                            rDataProvider.pwdController.value.text.trim();
                        String dateStrin =
                            rDataProvider.dateNaisSouscripteurController.text;
                        String lieuNaiss =
                            rDataProvider.lieuNaissController.text;
                        String address = rDataProvider.adressController.text;
                        String num = rDataProvider.numPieceController.text;
                        String? codeStr =
                            rDataProvider.codeClientController.text;
                        int code = 0;
                        if (codeStr.isNotEmpty) code = int.parse(codeStr);

                        int createdTimestamp =
                            DateTime.now().millisecondsSinceEpoch;
                        rDataProvider.typeDoc;

                        var payload = {
                          "photoProfil": base64Encode(rDataProvider.imgBytes),
                          "username": StringUtil.removeDash(phone),
                          "firstName": fName,
                          "pname": pName,
                          "dateNaiss": AMCassurDateUtils.parseDateEn(
                            dateStrin,
                            'dd/MM/yyy',
                          ),
                          "lieuNaiss": lieuNaiss,
                          "code": code,
                          "address": address,
                          "lastName": lastName,
                          "email": email.length == 0 ? null : email,
                          "password": password,
                          "createdTimestamp": createdTimestamp,
                          "enabled": true,
                          "totp": false,
                          "emailVerified": false,
                          "typeDoc": typeDoc,
                          "numDoc": num,
                          "docStr": rDataProvider.docBase64,
                          "dateExp": dateExp,
                          "typeFile": FileUtil.getFileExtension(
                            rDataProvider.getIdentityDoc()!.path,
                          )
                        };

                        await sendOtp(payload, rDataProvider.prefix_country);
                      }
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: isLoading
                          ? AmcLoader(color: AppColors.WHITE)
                          : Text(
                              'Créer un compte',
                              style: TextStyle(
                                color: AppColors.WHITE,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // CustomRow(selectedIndex: 2, count: 3, color: AppColors.WHITE),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendOtp(payload, String prefix_country) async {
    setState(() => isLoading = true);
    var dtoSendOtp = {
      "username": payload['username'],
      "prefix_country": prefix_country
    };
    String status = await OtpService.sendOTP(dtoSendOtp);
    // Code 200
    setState(() => isLoading = false);
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
      rawsurShowCustomDialog(
          context: context,
          text:
              "Service indisponible pour l'instant\nMerci de réesayer plus tard",
          confirmButtonText: "Ok");
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

      rawsurShowCustomDialog(
          context: context,
          text:
              "Service indisponible pour l'instant\nMerci de réesayer plus tard",
          confirmButtonText: "Ok");

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

  void showSnackbar(String title, String message) {
    AlertController.show(title, message, TypeAlert.error);
  }
}
