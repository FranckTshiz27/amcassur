import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/shared/widgets/amc_loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RawsurPhotoPickerBottomSheet extends StatefulWidget {
  const RawsurPhotoPickerBottomSheet({
    Key? key,
    required this.setIdentityCard,
  }) : super(key: key);

  final Function setIdentityCard;

  @override
  State<RawsurPhotoPickerBottomSheet> createState() =>
      _RawsurPhotoPickerBottomSheetState();
}

class _RawsurPhotoPickerBottomSheetState
    extends State<RawsurPhotoPickerBottomSheet> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .15,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Choisissez une photo",
            style: TextStyle(
              color: AppColors.BLUE,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * .05,
            ),
          ),
          SizedBox(height: 20),
          isLoading
              ? AmcLoader(color: AppColors.BLUE)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        Icons.camera,
                        color: AppColors.BLUE,
                      ),
                      onPressed: () async {
                        setState(() => isLoading = true);
                        XFile? pickedFile = await ImagePicker().pickImage(
                          source: ImageSource.camera,
                        );
                        widget.setIdentityCard(pickedFile);
                        setState(() => isLoading = false);
                        Navigator.pop(context);
                      },
                      label: Text(
                        "Camera",
                        style: TextStyle(
                          color: AppColors.BLUE,
                          fontSize: MediaQuery.of(context).size.width * .03,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      icon: Icon(
                        Icons.image,
                        color: AppColors.BLUE,
                      ),
                      onPressed: () async {
                        setState(() => isLoading = true);
                        // Sélectionnez un fichier avec file_picker
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
                        );

                        if (result != null && result.files.isNotEmpty) {
                          PlatformFile platformFile = result.files.first;

                          // Convertir PlatformFile en XFile
                          XFile xFile = XFile(platformFile.path!);

                          // Utilisez le XFile comme vous le souhaitez
                          print('XFile path: ${xFile.path}');
                          widget.setIdentityCard(xFile);
                        }
                        setState(() => isLoading = false);
                        Navigator.pop(context);
                      },
                      label: Text(
                        "Galerie",
                        style: TextStyle(
                          color: AppColors.BLUE,
                          fontSize: MediaQuery.of(context).size.width * .03,
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
