import 'dart:convert';
import 'dart:io';
import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/providers/register_data_provider.dart';
import 'package:amcassur/shared/widgets/amc_loader.dart';
import 'package:amcassur/shared/widgets/custom_text_form_field.dart';
import 'package:amcassur/styles/amc_style.dart';
import 'package:amcassur/views/auth/register/register_step3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class RegisterStep2 extends StatefulWidget {
  const RegisterStep2({super.key});

  @override
  State<RegisterStep2> createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  bool isLoading = false;
  late RegisterDataProvider rDataProvider;
  bool isImgLoading = false;
  bool isImgValidated = false;

  bool isSecuredPassword = true;
  bool isSecuredPasswordConfirm = true;

  String img64encode = '';

  String regexError =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*]).{8,}$';
  String errorMessage =
      'Le mot de passe doit avoir :\n - 8 caractères au minimum\n - au moins une lettre majuscule\n - au moins un chiffre\n - au moins un caractère spécial';

  final _register2Key = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColors.WHITE,
      body: Container(
        height: double.infinity,
        // decoration: const BoxDecoration(gradient: AppColors.APP_SCREENS),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 25, right: 25),
          // padding: EdgeInsets.only(top: 200),
          child: SingleChildScrollView(
            child: Form(
              key: _register2Key,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 80, bottom: 20),
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: CustomShape(),
                          child: Container(
                            height: 50,
                            color: AppColors.MAIN_COLOR,
                          ),
                        ),
                        imageProfile(),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      isImgValidated ? 'Placer une image de profil' : '',
                      style: TextStyle(color: AppColors.ERROR),
                    ),
                  ),
                  SizedBox(height: isImgValidated ? 10 : 0),
                  MyRawsurTextFormField(
                    controller: rDataProvider.pwdController,
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
                      Validators.required('Mot de passe obligatoire'),
                      Validators.patternString(regexError, errorMessage)
                    ]),
                  ),
                  SizedBox(height: 10),
                  MyRawsurTextFormField(
                    controller: rDataProvider.pwdConfirmController,
                    obscureText: isSecuredPasswordConfirm,
                    labelText: 'Confirmer le mot de passe',
                    color: AppColors.DARK_BLUE,
                    keyboardType: TextInputType.text,
                    suffixIcon: isSecuredPasswordConfirm
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onPressed: () {
                      setState(() {
                        isSecuredPasswordConfirm = !isSecuredPasswordConfirm;
                      });
                    },
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: Validators.compose([
                      Validators.required('Champs obligatoire'),
                      Validators.patternString(regexError, errorMessage),
                      rDataProvider.isEqual()
                    ]),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: MyRawsurStyle.myCustomButtonStyle,
                    onPressed: () async {
                      setState(() {
                        isImgValidated = !rDataProvider.imgBytes.isNotEmpty;
                      });
                      print(this.isImgValidated);
                      print(_register2Key.currentState!.validate());
                      if (_register2Key.currentState!.validate()) {
                        if (rDataProvider.imgBytes.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterStep3(),
                            ),
                          );
                        }
                      }

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => RegisterStep3(
                      //       rData: widget.rData,
                      //     ),
                      //   ),
                      // );
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: isLoading
                          ? AmcLoader(color: AppColors.WHITE)
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
                  // SizedBox(height: 20),
                  // CustomRow(selectedIndex: 1, count: 3, color: AppColors.WHITE),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return isImgLoading
        ? AmcLoader(color: AppColors.WHITE)
        : Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: (rDataProvider.imgBytes.isEmpty)
                      ? AssetImage("assets/images/userImage4.jpg")
                      : Image.memory(rDataProvider.imgBytes).image,
                ),
                Positioned(
                  bottom: 5.0,
                  right: 2.0,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.MAIN_COLOR,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: InkWell(
                      onTap: () async {
                        img64encode = await takePhoto(ImageSource.camera);
                        setState(() =>
                            isImgValidated = rDataProvider.imgBytes.isEmpty);
                      },
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Future<String> takePhoto(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    // Navigator.pop(context);

    // pickedFile = await FileUtil.compressImageXFile(pickedFile!);

    Uint8List bytes = File(pickedFile!.path).readAsBytesSync();
    setState(() {
      isImgLoading = true;
    });
    String base64encode = base64Encode(bytes);

    setState(() {
      isImgLoading = false;
      rDataProvider.imgBytes = base64Decode(base64encode);
    });

    return base64encode;
  }

  IconButton togglePassword() {
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

  IconButton togglePasswordConfirm() {
    return IconButton(
      onPressed: () {
        setState(() {
          isSecuredPasswordConfirm = !isSecuredPasswordConfirm;
        });
      },
      icon: isSecuredPasswordConfirm
          ? Icon(Icons.visibility_off)
          : Icon(Icons.visibility),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
