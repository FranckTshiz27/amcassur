import 'dart:convert';

import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/configs/preference.dart';
import 'package:amcassur/configs/preferencekeys.dart';
import 'package:amcassur/enum/type_identity_doc.dart';
import 'package:amcassur/service/formatter.dart';
import 'package:amcassur/service/user.service.dart';
import 'package:amcassur/shared/utils/date_utils.dart';
import 'package:amcassur/shared/utils/fileUtil.dart';
import 'package:amcassur/shared/utils/string_util.dart';
import 'package:amcassur/shared/widgets/amc_loader.dart';
import 'package:amcassur/shared/widgets/custom_alert.dart';
import 'package:amcassur/shared/widgets/custom_text_form_field.dart';
import 'package:amcassur/styles/amc_style.dart';
import 'package:amcassur/views/auth/update-profil/provider/update_data.dart';
import 'package:amcassur/views/auth/update-profil/widgets/card_identity2.dart';
import 'package:amcassur/views/home/home_view.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class UpdateProfilStep2 extends StatefulWidget {
  const UpdateProfilStep2({super.key, required this.uData});

  final UpdateData uData;

  @override
  State<UpdateProfilStep2> createState() => _UpdateProfilStep2State();
}

class _UpdateProfilStep2State extends State<UpdateProfilStep2>
    with TickerProviderStateMixin {
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
      backgroundColor: AppColors.DARK_BLUE,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.APP_SCREENS),
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
                      color: AppColors.WHITE,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * .05,
                    ),
                  ),
                  SizedBox(height: 20),
                  MyRawsurTextFormField(
                    controller: widget.uData.numPieceController,
                    labelText: "Numero de pièce d'identité",
                    color: AppColors.WHITE,
                    keyboardType: TextInputType.text,
                    inputFormatters: [RigthTrimFormatter()],
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
                        CardIdentityUpdate(
                          index: 0,
                          title: "Passeport",
                          uData: widget.uData,
                          typeDoc: TypeIdentityDoc.passport,
                        ),
                        CardIdentityUpdate(
                          index: 1,
                          title: "Carte d'électeur",
                          uData: widget.uData,
                          typeDoc: TypeIdentityDoc.carte_electeur,
                        ),
                        CardIdentityUpdate(
                          index: 2,
                          title: "Permis de conduire",
                          uData: widget.uData,
                          typeDoc: TypeIdentityDoc.permis_conduire,
                        ),
                        CardIdentityUpdate(
                          index: 3,
                          title: "Carte d'agent de l'ordre",
                          uData: widget.uData,
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
                        if (widget.uData.getIdentityDoc() == null) {
                          await rawsurShowCustomDialog(
                            context: context,
                            type: ArtSweetAlertType.danger,
                            text: "Ajouter une photo de votre pièce d'identité",
                            confirmButtonText: "Ok",
                          );
                          return;
                        }

                        String dateExp =
                            widget.uData.dateExpPassporController.text;
                        String type_doc = getYpeDoc(widget.uData.typeDoc);
                        if (type_doc == 'passport') {
                          String? validateDateExp =
                              widget.uData.validateDateExp(dateExp);
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
                        String phone = widget.uData.phoneController.value.text;
                        String fName =
                            widget.uData.fnameController.value.text.trim();
                        String pName =
                            widget.uData.pnameController.value.text.trim();
                        String lastName =
                            widget.uData.lnameController.value.text.trim();
                        String email =
                            widget.uData.emailController.value.text.trim();
                        String dateStrin =
                            widget.uData.dateNaisSouscripteurController.text;
                        String lieuNaiss =
                            widget.uData.lieuNaissController.text;
                        String address = widget.uData.adressController.text;
                        String num = widget.uData.numPieceController.text;

                        // int createdTimestamp =
                        //     DateTime.now().millisecondsSinceEpoch;
                        String dateEn = AMCassurDateUtils.parseDateEn(
                          dateStrin,
                          'dd/MM/yyy',
                        );
                        String typeFile = FileUtil.getFileExtension(
                          widget.uData.getIdentityDoc()!.path,
                        );

                        String? codeStr =
                            widget.uData.codeClientController.text;
                        int code = 0;
                        if (codeStr.isNotEmpty) code = int.parse(codeStr);

                        Map<String, dynamic> payload = {
                          "username": StringUtil.removeDash(phone),
                          "firstname": fName,
                          "pname": pName,
                          "lastname": lastName,
                          "datenaiss": dateEn,
                          "code": code,
                          "lieunaiss": lieuNaiss,
                          "address": address,
                          "email": email.length == 0 ? null : email,
                          "typedoc": type_doc,
                          "numdoc": num,
                          "docstr": widget.uData.docBase64,
                          "typeFile": typeFile,
                          "dateExp": dateExp
                        };

                        // print(payload);
                        setState(() => isLoading = true);
                        dynamic response = await UserService.updateUser(
                          payload,
                        );
                        setState(() => isLoading = false);

                        if (response == 'OK') {
                          rawsurShowCustomDialog(
                            context: context,
                            text: "Votre profil a été mise à jour avec succès",
                            confirmButtonText: 'Ok',
                            type: ArtSweetAlertType.success,
                            onConfirm: () async {
                              if (code != 0) {
                                Preferences.set(
                                  PreferenceKeys.CODE_CLIENT,
                                  '$code',
                                );
                              }
                              Preferences.set(PreferenceKeys.F_NAME, fName);
                              Preferences.set(PreferenceKeys.L_NAME, lastName);
                              Preferences.set(PreferenceKeys.P_NAME, pName);
                              Preferences.set(PreferenceKeys.ADDRESS, address);
                              Preferences.set(
                                  PreferenceKeys.DATE_NAISS, dateEn);
                              Preferences.set(
                                  PreferenceKeys.LIEU_NAISS, lieuNaiss);
                              Preferences.set(PreferenceKeys.EMAIL, email);
                              Preferences.set(PreferenceKeys.NUM_DOC, num);
                              Preferences.set(
                                  PreferenceKeys.TYPE_DOC, type_doc);
                              Preferences.set(
                                  PreferenceKeys.TYPE_FILE, typeFile);
                              String? doc = widget.uData.docBase64;
                              if (doc != null) {
                                Preferences.set(PreferenceKeys.DOC, doc);
                                UserService.passportFile =
                                    await FileUtil.base64ToXFile(
                                  base64String: doc,
                                  extention: typeFile,
                                );
                              }

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeView(),
                                ),
                              );
                            },
                          );
                        }
                      }
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: isLoading
                          ? AmcLoader(
                              color: AppColors.BLUE,
                            )
                          : Text(
                              'Mettre à jour son profil',
                              style: TextStyle(
                                color: AppColors.DARK_BLUE,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // CustomRow(selectedIndex: 1, count: 2, color: AppColors.WHITE),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
