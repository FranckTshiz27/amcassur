import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/service/formatter.dart';
import 'package:amcassur/service/user.service.dart';
import 'package:amcassur/shared/utils/date_utils.dart';
import 'package:amcassur/shared/utils/string_util.dart';
import 'package:amcassur/shared/widgets/amc_loader.dart';
import 'package:amcassur/shared/widgets/custom_alert.dart';
import 'package:amcassur/shared/widgets/custom_intl_phone_field.dart';
import 'package:amcassur/shared/widgets/custom_text_form_field.dart';
import 'package:amcassur/styles/amc_style.dart';
import 'package:amcassur/views/auth/update-profil/provider/update_data.dart';
import 'package:amcassur/views/auth/update-profil/update_profil_step2.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:intl/intl.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class UpdateProfilStep1 extends StatefulWidget {
  const UpdateProfilStep1({super.key, required this.uData});

  final UpdateData uData;

  @override
  State<UpdateProfilStep1> createState() => _UpdateProfilStep1State();
}

class _UpdateProfilStep1State extends State<UpdateProfilStep1> {
  final _updateUser1Key = GlobalKey<FormState>();

  bool isLoading = false;

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
        widget.uData.dateNaisSouscripteurController.text = dateFormated;
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
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.APP_SCREENS),
        child: Center(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _updateUser1Key,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .11),
                    margin: EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyRawsurTextFormField(
                          controller: widget.uData.lnameController,
                          labelText: 'Nom',
                          color: AppColors.WHITE,
                          keyboardType: TextInputType.text,
                          inputFormatters: [RigthTrimFormatter()],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: Validators.compose(
                            [Validators.required("Le nom est obligatoire")],
                          ),
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          controller: widget.uData.pnameController,
                          labelText: 'Postnom',
                          color: AppColors.WHITE,
                          keyboardType: TextInputType.text,
                          inputFormatters: [RigthTrimFormatter()],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          controller: widget.uData.fnameController,
                          labelText: 'Prénom',
                          color: AppColors.WHITE,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [RigthTrimFormatter()],
                          validator: Validators.compose([
                            Validators.required("Le prénom est obligatoire"),
                          ]),
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          controller: widget.uData.codeClientController,
                          labelText: 'Code client',
                          color: AppColors.WHITE,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          controller: widget.uData.emailController,
                          labelText: 'Email',
                          color: AppColors.WHITE,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(70),
                            RigthTrimFormatter()
                          ],
                          validator: Validators.compose([
                            Validators.email(
                              'Votre adresse e-mail est incorrecte',
                            )
                          ]),
                        ),
                        SizedBox(height: 10),
                        CustomIntlPhoneField(
                          controller: widget.uData.phoneController,
                          labelText: "Téléphone",
                          color: AppColors.WHITE,
                          searchLabelText: 'Rechercher un pays',
                          onCountryChanged: (country) {
                            widget.uData.prefix_country =
                                '+${country.fullCountryCode}';
                          },
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          maxLines: 2,
                          controller: widget.uData.adressController,
                          labelText: 'Adresse',
                          color: AppColors.WHITE,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: Validators.compose([
                            Validators.required("L'adresse est obligatoire")
                          ]),
                        ),
                        SizedBox(height: 10),
                        MyRawsurTextFormField(
                          controller: widget.uData.lieuNaissController,
                          labelText: 'Lieu de naissance',
                          color: AppColors.WHITE,
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
                              widget.uData.dateNaisSouscripteurController,
                          labelText: 'Date de naissance',
                          color: AppColors.WHITE,
                          keyboardType: TextInputType.datetime,
                          suffixIcon: Icons.calendar_month,
                          validator: widget.uData.validateDateField(),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          style: MyRawsurStyle.myCustomButtonStyle,
                          onPressed: () async {
                            String phone = widget.uData.phoneController.text;
                            phone = StringUtil.removeDash(phone);
                            if (_updateUser1Key.currentState!.validate()) {
                              if (phone.length != 9) {
                                await ArtSweetAlert.show(
                                  barrierDismissible: false,
                                  context: context,
                                  artDialogArgs: ArtDialogArgs(
                                    type: ArtSweetAlertType.danger,
                                    title: 'My Rawsur info',
                                    text:
                                        'Saisissez un numero de téléphone valide',
                                    confirmButtonText: "Ok",
                                    showCancelBtn: false,
                                  ),
                                );
                                return;
                              }
                              setState(() => isLoading = true);
                              dynamic response =
                                  await UserService.getUserByUsername(
                                phone,
                              );
                              print('RESPONSE : $response');
                              setState(() => isLoading = false);
                              print('RESPONSE : ${response == null}');
                              print('RESPONSE : ${response == ''}');
                              print('STATUS : ${UserService.statusResponse}');
                              if (response != '' &&
                                  UserService.statusResponse == 200) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateProfilStep2(
                                      uData: widget.uData,
                                    ),
                                  ),
                                );
                              } else {
                                String message =
                                    "Il n'y a aucun utilisateur avec le numero +243$phone";
                                if (UserService.statusResponse != 200) {
                                  message = response;
                                }
                                await rawsurShowCustomDialog(
                                  context: context,
                                  text: message,
                                  type: ArtSweetAlertType.danger,
                                  confirmButtonText: "Ok",
                                  onConfirm: () {
                                    return;
                                  },
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
                                    color: AppColors.DARK_BLUE,
                                  )
                                : Text(
                                    'Suivant',
                                    style: TextStyle(
                                      color: AppColors.DARK_BLUE,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // CustomRow(
                        //   selectedIndex: 0,
                        //   count: 2,
                        //   color: AppColors.WHITE,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              DropdownAlert()
            ],
          ),
        ),
      ),
    );
  }
}
