import 'dart:convert';
import 'dart:io';
import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/configs/preference.dart';
import 'package:amcassur/configs/preferencekeys.dart';
import 'package:amcassur/enum/type_identity_doc.dart';
import 'package:amcassur/service/auth.service.dart';
import 'package:amcassur/service/user.service.dart';
import 'package:amcassur/shared/utils/convert_token.dart';
import 'package:amcassur/shared/utils/date_utils.dart';
import 'package:amcassur/shared/utils/fileUtil.dart';
import 'package:amcassur/shared/utils/string_util.dart';
import 'package:amcassur/views/auth/update-profil/provider/update_data.dart';
import 'package:amcassur/views/auth/update-profil/update_profil_step1.dart';
import 'package:amcassur/views/auth/updatepassword.screen.dart';
import 'package:amcassur/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // int _currentIndex = 2;
  late File imgFile;
  late Uint8List imgBytes = Uint8List.fromList([]);
  // XFile? _imageFile = null;
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();

  Map<String, dynamic>? token = null;
  var prefix_country;
  var phone_number;

  Widget imageProfile() {
    return isLoading
        ? Center(
            child: const CircularProgressIndicator(
              color: AppColors.BLUE,
              backgroundColor: Colors.grey,
            ),
          )
        : Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: (imgBytes.length == 0)
                      ? AssetImage("assets/images/userImage4.jpg")
                      : Image.memory(imgBytes).image,
                ),
                Positioned(
                  bottom: 5.0,
                  right: 2.0,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: AppColors.BLUE,
                        borderRadius: BorderRadius.circular(25)),
                    child: InkWell(
                      onTap: () async {
                        takePhoto(ImageSource.camera);
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

  TypeIdentityDoc getYpeDoc(String typeDoc) {
    switch (typeDoc) {
      case 'passport':
        return TypeIdentityDoc.passport;
      case 'carte_electeur':
        return TypeIdentityDoc.carte_electeur;
      case 'permis_conduire':
        return TypeIdentityDoc.permis_conduire;
      default:
        return TypeIdentityDoc.carte_agent_ordre;
    }
  }

  void takePhoto(ImageSource source) async {
    XFile? pickedFile = await _picker.pickImage(source: source);

    final bytes = File(pickedFile!.path).readAsBytesSync();
    setState(() => isLoading = true);
    String base64encode = base64Encode(bytes);
    bool response = await UserService.updateProfile(
      pickedFile,
      token!['preferred_username'],
    );

    if (response) {
      Preferences.set(PreferenceKeys.PROFILE, base64encode);
      setState(() {
        isLoading = false;
        imgBytes = base64Decode(Preferences.get(PreferenceKeys.PROFILE)!);
      });
    } else {
      setState(() => isLoading = false);
      final snackBar = SnackBar(
        content: const Text("La mise à jour du profil n'a pas abouti"),
        action: SnackBarAction(label: 'Merci de réesayer', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? lname = Preferences.get(PreferenceKeys.L_NAME) != null &&
            Preferences.get(PreferenceKeys.L_NAME)!.isNotEmpty
        ? Preferences.get(PreferenceKeys.L_NAME)
        : "";
    String? fname = Preferences.get(PreferenceKeys.F_NAME) != null &&
            Preferences.get(PreferenceKeys.F_NAME)!.isNotEmpty
        ? Preferences.get(PreferenceKeys.F_NAME)
        : "";
    // return StoreConnector<AppState, AppState>(
    //   onInit: (store) {
    //     StoreProvider.of<AppState>(context).dispatch(
    //       UPDATE_SESSION_TIME(DateTime.now()),
    // ,
    // converter: (store) => store.state,
    // builder: (context, state) {
    // StoreProvider.of<AppState>(context).dispatch(
    //   UPDATE_CURRENTINDEX(3),
    // );

    String? profil = Preferences.get(PreferenceKeys.PROFILE);
    if (profil != null && profil != '') {
      imgBytes = base64Decode(profil);
    } else if (profil == '') {
      imgBytes = Uint8List.fromList([]);
    }

    prefix_country = Preferences.get(PreferenceKeys.PREFIX_COUNTRY);
    phone_number = Preferences.get(PreferenceKeys.PHONE_NUMBER);

    String? token_pref = Preferences.get(PreferenceKeys.TOKEN);
    token = ConvertToken.convert(token_pref);

    // _currentIndex = 2;

    print(
        " ------------ ****************** 555555555555 FIN ***************** -----------------");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.BLUE,
        elevation: 0.0,
        // title: Text("Profile"),
        centerTitle: true,
        foregroundColor: Colors.white,
        actions: [
          // GestureDetector(
          //   child: Row(
          //     children: [
          //       Image.asset(
          //         'assets/refonte/NotififcationsCLOCHE.png',
          //         width: 20,
          //         height: 20,
          //       ),
          //       Text('   ')
          //     ],
          //   ),
          //   onTap: () {
          //     print('TEST');
          //   },
          // ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: AppColors.BAGROUND),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: CustomShape(),
                    child: Container(
                      height: 160,
                      color: AppColors.BLUE,
                    ),
                  ),
                  imageProfile(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                // color: AppColors.BLUE.withOpacity(.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$lname ${token!['given_name']}',
                    style: TextStyle(
                      color: AppColors.BLUE,
                      fontSize: MediaQuery.of(context).size.width * .05,
                      fontWeight: FontWeight.bold,
                    ),
                    // GoogleFonts.roboto(color: Colors.black, fontSize: 18),
                  ),
                  Divider(color: Colors.black),
                  Text(
                    '${prefix_country} ${StringUtil.addSpaceEveryThreeChars(phone_number)}',
                    style: TextStyle(
                      color: AppColors.BLUE,
                      fontSize: MediaQuery.of(context).size.width * .05,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: AppColors.BLUE.withOpacity(.1),
              endIndent: 15,
              indent: 15,
              thickness: 1.5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdatepasswordScreen(),
                        ),
                      );
                    },
                    child: Card(
                      color: AppColors.BAGROUND,
                      child: ListTile(
                        leading: Icon(
                          Icons.lock_person_outlined,
                          color: AppColors.BLUE,
                          size: 30,
                        ),
                        title: Text(
                          'Changer le mot de passe',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .035,
                            fontWeight: FontWeight.bold,
                            color: AppColors.BLUE,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.BLUE,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      String? code =
                          Preferences.get(PreferenceKeys.CODE_CLIENT);
                      String? pname = Preferences.get(PreferenceKeys.P_NAME) !=
                                  null &&
                              Preferences.get(PreferenceKeys.P_NAME)!.isNotEmpty
                          ? Preferences.get(PreferenceKeys.P_NAME)
                          : "";

                      String? email = Preferences.get(PreferenceKeys.EMAIL) !=
                                  null &&
                              Preferences.get(PreferenceKeys.EMAIL)!.isNotEmpty
                          ? Preferences.get(PreferenceKeys.EMAIL)
                          : "";
                      String? phone =
                          Preferences.get(PreferenceKeys.PHONE_NUMBER) !=
                                      null &&
                                  Preferences.get(PreferenceKeys.PHONE_NUMBER)!
                                      .isNotEmpty
                              ? Preferences.get(PreferenceKeys.PHONE_NUMBER)
                              : "";
                      String? lieuNaiss =
                          Preferences.get(PreferenceKeys.LIEU_NAISS) != null &&
                                  Preferences.get(PreferenceKeys.LIEU_NAISS)!
                                      .isNotEmpty
                              ? Preferences.get(PreferenceKeys.LIEU_NAISS)
                              : "";
                      String? adress =
                          Preferences.get(PreferenceKeys.ADDRESS) != null &&
                                  Preferences.get(PreferenceKeys.ADDRESS)!
                                      .isNotEmpty
                              ? Preferences.get(PreferenceKeys.ADDRESS)
                              : "";
                      String? numDoc =
                          Preferences.get(PreferenceKeys.NUM_DOC) != null &&
                                  Preferences.get(PreferenceKeys.NUM_DOC)!
                                      .isNotEmpty
                              ? Preferences.get(PreferenceKeys.NUM_DOC)
                              : "";
                      String? dateString =
                          Preferences.get(PreferenceKeys.DATE_NAISS);
                      String? typeDoc =
                          Preferences.get(PreferenceKeys.TYPE_DOC) != null &&
                                  Preferences.get(PreferenceKeys.TYPE_DOC)!
                                      .isNotEmpty
                              ? Preferences.get(PreferenceKeys.TYPE_DOC)
                              : "";
                      Preferences.get(PreferenceKeys.TYPE_DOC);
                      String? typeFile =
                          Preferences.get(PreferenceKeys.TYPE_FILE);
                      String? dateExp = Preferences.get(
                          PreferenceKeys.DATE_EXPIRATION_PASSEPORT);

                      UpdateData uData = UpdateData();
                      uData.fnameController.text = fname ?? '';
                      uData.lnameController.text = lname ?? '';
                      uData.pnameController.text = pname ?? '';
                      uData.emailController.text = email ?? '';
                      uData.phoneController.text = phone ?? '';
                      uData.lieuNaissController.text = lieuNaiss ?? '';
                      uData.adressController.text = adress ?? '';
                      uData.numPieceController.text = numDoc ?? '';
                      uData.codeClientController.text = code ?? '';

                      if (dateString != null && dateString.isNotEmpty) {
                        DateTime dateNaiss =
                            DateFormat("yyyy-MM-dd").parse(dateString);
                        dateString = AMCassurDateUtils.formatDate(dateNaiss);
                        uData.dateNaisSouscripteurController.text = dateString;
                      }

                      if (typeDoc != null && typeFile != null) {
                        TypeIdentityDoc typeDocEnum = getYpeDoc(typeDoc);
                        uData.typeDoc = typeDocEnum;
                        XFile? passportFile = UserService.passportFile;
                        uData.setIdentityDoc(passportFile);

                        uData.docBase64 = FileUtil.xFileToBase64(
                          passportFile,
                        );
                      }

                      if (dateExp != null && dateExp.isNotEmpty) {
                        uData.dateExpPassporController.text = dateExp;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProfilStep1(
                            uData: uData,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: AppColors.BAGROUND,
                      child: ListTile(
                        leading: Icon(
                          Icons.person_outline_sharp,
                          color: AppColors.BLUE,
                          size: 30,
                        ),
                        title: Text(
                          'Mettre à jour son profil',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .035,
                            fontWeight: FontWeight.bold,
                            color: AppColors.BLUE,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.BLUE,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      AuthService.logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                        (route) => false,
                      );
                    },
                    child: Card(
                      color: AppColors.BAGROUND,
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: AppColors.BLUE,
                          size: 30,
                        ),
                        title: Text(
                          'Se deconnecter',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .035,
                            fontWeight: FontWeight.bold,
                            color: AppColors.BLUE,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.BLUE,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomBar(token, state.startDate),
      // bottomNavigationBar: AppBottomBar(isHome: false),
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
