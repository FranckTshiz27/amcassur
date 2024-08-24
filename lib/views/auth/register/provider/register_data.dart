import 'dart:typed_data';

import 'package:amcassur/enum/type_identity_doc.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class RegisterData {
  TextEditingController numPieceController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController pnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController lieuNaissController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codeClientController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController pwdConfirmController = TextEditingController();
  TextEditingController dateNaisSouscripteurController =
      TextEditingController();
  TextEditingController dateExpPassporController = TextEditingController();
  MaskedTextController phoneController =
      MaskedTextController(mask: "000-000-000");

  String prefix_country = '+243';

  Uint8List imgBytes = Uint8List.fromList([]);

  XFile? _identityDoc;
  String? docBase64;
  TypeIdentityDoc typeDoc = TypeIdentityDoc.carte_electeur;

  XFile? getIdentityDoc() => _identityDoc;

  void setIdentityDoc(XFile? doc) => _identityDoc = doc;

  // String? Function(String?)? validateDateField() {
  //   return Validators.compose([
  //     (String? value) => validateDate(),
  //     (String? value) => isAdult(),
  //   ]);
  // }

  // String? validateDate() {
  //   bool isValid = RawsurDateUtils.isDateInFormat(
  //     this.dateNaisSouscripteurController.text,
  //     'dd/MM/yyyy',
  //   );
  //   if (isValid) return null;
  //   return "Date non valide";
  // }

  // String? validateDateExp(String date) {
  //   bool isValid = RawsurDateUtils.isDateInFormat(
  //     date,
  //     'dd/MM/yyyy',
  //   );
  //   if (isValid) return null;
  //   return "Date non valide";
  // }

  // String? isAdult() {
  //   bool isAdult = RawsurDateUtils.adult(dateNaisSouscripteurController.text);
  //   print('$isAdult');
  //   if (isAdult) return null;
  //   return "Vous n'etes pas majeur";
  // }

  // String? Function(String?)? validateField(String nameField) {
  //   return Validators.compose([
  //     // (String? value) => checkIfCaracteSpecial(valueField, nameField),
  //     Validators.required("Le $nameField est obligatoire")
  //   ]);
  // }

  // String? Function(String?) isEqual() {
  //   return Validators.compose([
  //     (String? value) {
  //       bool test = pwdController.text == pwdConfirmController.text;
  //       return test ? null : 'deux mots de passe non identiques';
  //     },
  //   ]);
  // }

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
}
