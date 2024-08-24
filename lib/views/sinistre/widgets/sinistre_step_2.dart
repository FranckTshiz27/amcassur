import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/appcolors.dart';

class SinistreStep2 extends StatefulWidget {
  const SinistreStep2({super.key});

  @override
  State<SinistreStep2> createState() => _SinistreStep2State();
}

class _SinistreStep2State extends State<SinistreStep2> {
  PlatformFile? attestAssurence;
  PlatformFile? permiConduire;
  PlatformFile? carteRose;
  bool isCkecked = false;

  bool isLoading = false;

  String wrapText(String text) {
    if (text.length >= 25) {
      return text.substring(0, 25) + '.pdf';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.textScalerOf(context).scale(9);
    double sizeCar = MediaQuery.textScalerOf(context).scale(12);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.MAIN_COLOR.withOpacity(0.05),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white.withOpacity(0.05),
            ),
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //     'Police : ${state.risque?.codeint}-${state.risque?.numpoli}-${state.risque?.numave}'),
                Text(
                  'Police :',
                  style: TextStyle(fontSize: sizeCar),
                ),
                Text(
                  'Matricule : ',
                  style: TextStyle(fontSize: sizeCar),
                ),
                Text(
                  'Marque : ',
                  style: TextStyle(fontSize: sizeCar),
                ),
                // Text('Permis : ${state.risque?.engineNumber}'),
                Text(
                  'chassis : ',
                  style: TextStyle(fontSize: sizeCar),
                ),
                // Text('dmc : ${state.risque?.dmc}'),
              ],
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: 2,
            maxLines: null,
            decoration: InputDecoration(
              fillColor: Colors.white.withOpacity(.6),
              filled: true,
              hintText: "Décrivez le scénario",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            onChanged: (value) {},
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isCkecked
                      ? "Ne pas envoyer la localisation"
                      : "Envoyer la localisation",
                ),
                Switch(
                  value: isCkecked,
                  onChanged: (value) {
                    isCkecked = !isCkecked;
                  },
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.MAIN_COLOR.withOpacity(0.05),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white.withOpacity(0.05),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        // await choiceAttestationFile();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.picture_as_pdf),
                          Text(
                            attestAssurence == null
                                ? "Attestation d'assurance (auccun fichier séléctionné)"
                                : wrapText(attestAssurence!.name),
                            style: TextStyle(fontSize: size),
                          )
                        ],
                      ),
                    ),
                    attestAssurence != null
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                attestAssurence = null;
                              });
                            },
                            icon: Icon(Icons.cancel_outlined),
                          )
                        : Text(''),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        // await choicePermisFile();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.picture_as_pdf),
                          Text(
                            permiConduire == null
                                ? "Permis de conduir (auccun fichier séléctionné)"
                                : wrapText(permiConduire!.name),
                            style: TextStyle(fontSize: size),
                          )
                        ],
                      ),
                    ),
                    permiConduire != null
                        ? IconButton(
                            onPressed: () {
                              setState(() => permiConduire = null);
                            },
                            icon: Icon(Icons.cancel_outlined),
                          )
                        : Text(''),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        // await choiceCarteRoseFile();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.picture_as_pdf),
                          Text(
                            carteRose == null
                                ? "Carte rose (auccun fichier séléctionné)"
                                : wrapText(carteRose!.name),
                            style: TextStyle(fontSize: size),
                          )
                        ],
                      ),
                    ),
                    carteRose != null
                        ? IconButton(
                            onPressed: () {
                              setState(() => carteRose = null);
                            },
                            icon: Icon(Icons.cancel_outlined),
                          )
                        : Text(''),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.MAIN_COLOR.withOpacity(0.05),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white.withOpacity(0.05),
            ),
            child: ListTile(
              title: true
                  ? Text(
                      'Ajouter les images',
                      style: TextStyle(fontSize: 20),
                    )
                  : Text("Nombre d'images : "),
              subtitle: true
                  ? Text('')
                  : Text(
                      "Taille total : ",
                    ),
              leading: IconButton(
                onPressed: () async {
                  // await showOptionalDialog(context);
                  // await showImagePickerOption(context);
                },
                icon: Icon(
                  Icons.photo_camera_rounded,
                  color: AppColors.MAIN_COLOR,
                  size: 40,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey.withOpacity(.2)),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
