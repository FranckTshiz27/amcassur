import 'dart:io';

import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/enum/type_identity_doc.dart';
import 'package:amcassur/providers/register_data.dart';
import 'package:amcassur/providers/register_data_provider.dart';
import 'package:amcassur/shared/utils/date_utils.dart';
import 'package:amcassur/shared/utils/fileUtil.dart';
import 'package:amcassur/shared/utils/rawsur_photo_picker_bottom_sheet.dart';
import 'package:amcassur/shared/widgets/amc_loader.dart';
import 'package:amcassur/shared/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CardIdentity extends StatefulWidget {
  const CardIdentity({
    super.key,
    required this.index,
    required this.title,
    required this.typeDoc,
  });

  final int index;
  final String title;
  // final RegisterData rData;
  final TypeIdentityDoc typeDoc;

  @override
  State<CardIdentity> createState() => _CardIdentityState();
}

class _CardIdentityState extends State<CardIdentity> {
  XFile? pickedFile;
  bool isLoading = false;
  bool isPassport = false;
  bool isSelected = false;
  String extention = 'pdf';
  String filName = '';
  late RegisterDataProvider rDataProvider;
  void setIdentityCard(XFile xFile) {
    pickedFile = xFile;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
      builder: (context, child) => AMCassurDateUtils.styleDatePicker(
        context,
        child,
      ),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        String dateFormated = DateFormat('dd/MM/yyyy').format(pickedDate);
        rDataProvider.dateExpPassporController.text = dateFormated;
        // date = pickedDate.toLocal();
      });
    }
  }

  Future<void> showPhotoPickerBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      backgroundColor: Colors.white.withOpacity(1),
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
        minWidth: double.infinity,
      ),
      context: context,
      builder: (context) {
        return RawsurPhotoPickerBottomSheet(setIdentityCard: setIdentityCard);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    rDataProvider = Provider.of<RegisterDataProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    isSelected = rDataProvider.typeDoc == widget.typeDoc;

    Icon icon = Icon(
      Icons.camera_alt,
      size: MediaQuery.of(context).size.height * .2,
      color: AppColors.DARK_BLUE,
    );

    XFile? f = rDataProvider.getIdentityDoc();
    if (f != null) {
      extention = FileUtil.getFileExtension(f.path);
      filName = FileUtil.getFileName(f.path);
    }

    // print('PATH : ${widget.rData.getIdentityDoc()?.path}');

    isPassport = widget.title == 'Passeport';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.DARK_BLUE.withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: isLoading
          ? AmcLoader(color: AppColors.WHITE)
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: AppColors.DARK_BLUE,
                  ),
                ),
                isPassport
                    ? Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: MyRawsurTextFormField(
                          controller: rDataProvider.dateExpPassporController,
                          labelText: "Date expiration passeport",
                          color: AppColors.DARK_BLUE,
                          keyboardType: TextInputType.datetime,
                          suffixIcon: Icons.calendar_month,
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                      )
                    : Container(),
                SizedBox(height: 20),
                Flexible(
                  child: IconButton(
                    onPressed: () async {
                      // _showDetail(context);
                      print('IMAGE : ${pickedFile == null}');

                      await showPhotoPickerBottomSheet(context);

                      print('IMAGE : ${pickedFile == null}');
                      if (pickedFile != null) {
                        // Vérifiez l'extension du fichier
                        setState(() => isLoading = true);
                        pickedFile = await FileUtil.compressImageXFile(
                          pickedFile!,
                        );
                        rDataProvider.setIdentityDoc(pickedFile);
                        rDataProvider.typeDoc = widget.typeDoc;
                        rDataProvider.docBase64 = FileUtil.xFileToBase64(
                          pickedFile,
                        );
                      }
                      setState(() => isLoading = false);
                    },
                    icon: rDataProvider.getIdentityDoc() == null
                        ? icon
                        : isSelected
                            ? extention == 'pdf'
                                ? Container(
                                    alignment: Alignment.center,
                                    height:
                                        MediaQuery.of(context).size.height * .2,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/pdf.png'),
                                        // fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      filName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .02,
                                        color: AppColors.DARK_BLUE,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        .25,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(rDataProvider
                                              .getIdentityDoc()!
                                              .path),
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  )
                            : icon,
                  ),
                )
              ],
            ),
    );
  }
}
