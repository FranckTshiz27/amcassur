import 'dart:async';

import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/configs/constants.dart';
import 'package:amcassur/service/auth.service.dart';
import 'package:amcassur/service/otp.service.dart';
import 'package:amcassur/shared/widgets/amc_loader.dart';
import 'package:amcassur/views/auth/register/widgets/valideChangePassword.screen.dart';
import 'package:amcassur/views/auth/register/widgets/valideOtp.screen.dart';
import 'package:amcassur/views/auth/register/widgets/valideResetPassword.screen.dart';
import 'package:amcassur/views/home/home_view.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({
    Key? key,
    required this.payload,
    required this.prefix_country,
    required this.preview_widget,
  }) : super(key: key);

  final Map<String, dynamic> payload;
  final String prefix_country;
  final String preview_widget;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isLoading = false;
  // double width = 45;
  // double height = 45;
  String otp = '';

  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  Timer? _timer;
  int _start = 60; // 60 secondes

  void startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (_start == 0) {
          setState(() => timer.cancel());
        } else {
          setState(() => _start--);
        }
      },
    );
  }

  Container buildOTPBox(int index) {
    // Map<String, dynamic> dtoAfnv = widget.dData.dtoAfnv;
    // int idCat = dtoAfnv['IDENCATE'];
    return Container(
      width: MediaQuery.of(context).size.width * .115,
      height: 50,
      alignment: Alignment.center,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.DARK_BLUE),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.DARK_BLUE),
            borderRadius: appRadius,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.DARK_BLUE),
            borderRadius: appRadius,
          ),
          labelStyle: TextStyle(color: AppColors.DARK_BLUE),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          border: OutlineInputBorder(borderRadius: appRadius),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) async {
          if (value.length == 1 && index < controllers.length - 1) {
            if (FocusScope.of(context).focusedChild == focusNodes[index]) {
              FocusScope.of(context).nextFocus();
            }
          }

          otp = '${controllers[0].text}' +
              '${controllers[1].text}' +
              '${controllers[2].text}' +
              '${controllers[3].text}' +
              '${controllers[4].text}' +
              '${controllers[5].text}';

          print(otp.length);

          if (otp.length == 6) {
            FocusScope.of(context).unfocus();
            register(widget.payload, otp);
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controllers = List.generate(6, (_) => TextEditingController());
    focusNodes = List.generate(6, (_) => FocusNode());
    focusNodes[0].requestFocus();
    startTimer();
  }

  @override
  void dispose() {
    controllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((node) => node.dispose());
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String prefix_country = widget.prefix_country;
    String phone = widget.payload['username'];
    phone = phone.replaceRange(2, 3, "*");
    phone = phone.replaceRange(3, 4, "*");
    phone = phone.replaceRange(4, 5, "*");
    phone = phone.replaceRange(5, 6, "*");
    phone = phone.replaceRange(6, 7, "*");

    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    String formattedTime =
        '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
    print('TIME : $_start');
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
        // decoration: const BoxDecoration(gradient: AppColors.APP_SCREENS),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      if (_start == 0) {
                        _start = 60;
                        for (var c in controllers) {
                          c.clear();
                        }
                        focusNodes[0].requestFocus();
                        setState(() => isLoading = true);
                        await resendOtp(
                          widget.payload['username'],
                          this.widget.prefix_country,
                        );
                        startTimer();
                        setState(() => isLoading = false);
                      }
                    },
                    child: Text(
                      "Renvoyer l'OTP   $formattedTime",
                      style: TextStyle(
                        color: AppColors.DARK_BLUE,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              CircleAvatar(
                child: Icon(
                  Icons.lock,
                  size: 50,
                ),
                radius: 45,
              ),
              SizedBox(height: 10),
              Text(
                'Vérification du code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.DARK_BLUE,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Veuillez entrer le code envoyé au : ${prefix_country} ${phone}',
                style: TextStyle(color: AppColors.DARK_BLUE),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) => buildOTPBox(index)),
              ),
              SizedBox(height: 50),
              Center(
                child: isLoading
                    ? AmcLoader(color: AppColors.DARK_BLUE)
                    : Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resendOtp(String username, String prefix_country) async {
    var dtoSendOtp = {'username': username, 'prefix_country': prefix_country};
    await OtpService.sendOTP(dtoSendOtp);
  }

  Future<void> register(payload, String code) async {
    setState(() => isLoading = true);
    var dtoverifyOTP = {'username': payload['username'], 'code': code};

    dynamic data = await OtpService.verifyOTP(dtoverifyOTP);
    String status = data['status'];
    print('STATUS OTP : $status');

    if (status == 'OTP_OK') {
      String status = "";
      print('CASE : ${widget.preview_widget}');
      if (widget.preview_widget == "REGISTER") {
        print('CASE : REGISTER===============');
        status = await AuthService.register(payload);
      } else if (widget.preview_widget == "CHANGE_PASSWORD") {
        print('CASE : CHANGE_PASSWORD===============');
        status = await AuthService.resetPassword(payload);
      } else if (widget.preview_widget == "RESET_PASSWORD") {
        print('CASE : RESET PASSWORD===============');
        status = await AuthService.resetPassword(payload);

        print(status);
      }
      setState(() => isLoading = false);
      if (status == 'SUCCESS') {
        if (widget.preview_widget == "REGISTER") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ValideOtpScreen(),
            ),
          );
        } else if (widget.preview_widget == "RESET_PASSWORD") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ValideResetPasswordScreen(),
            ),
          );
        } else if (widget.preview_widget == "CHANGE_PASSWORD") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ValideChangePasswordScreen(),
            ),
          );
        }
      } else if (status == 'ERROR') {
        ArtDialogResponse responseDialg = await ArtSweetAlert.show(
          barrierDismissible: false,
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.warning,
              title: "My Rawsur info",
              text:
                  "Service indisponible pour l'instant\nMerci de réesayer plus tard",
              confirmButtonText: "Ok"),
        );

        if (responseDialg.isTapConfirmButton) {
          // return at home page
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
            (route) => false,
          );
          return;
        }
      } else if (status == 'USERNAME_EXIST') {
        ArtDialogResponse responseDialg = await ArtSweetAlert.show(
          barrierDismissible: false,
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "My Rawsur info",
            text:
                "Ce numero de téléphone est déjà utilisé\nMerci de réesayer avec un autre.",
            confirmButtonText: "Ok",
          ),
        );

        if (responseDialg.isTapConfirmButton) {
          // return at register page
          Navigator.pop(context);
          return;
        }
      } else if (status == 'USERNAME_NOT_EXIST') {
        ArtDialogResponse responseDialg = await ArtSweetAlert.show(
          barrierDismissible: false,
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "My Rawsur info",
            text:
                "Ce numéro de téléphone n'existe pas dans notre base de donnée\nMerci de réesayer avec un autre.",
            confirmButtonText: "Ok",
          ),
        );

        if (responseDialg.isTapConfirmButton) {
          // return at register page
          Navigator.pop(context);
          return;
        }
      }
    } else if (status == 'OTP_ESPIRED') {
      setState(() => isLoading = false);

      // initialiser les champs

      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "My Rawsur info",
          text: "Ce code OTP est déjà expiré. Veuillez rédemander à nouveau.",
        ),
      );
    } else if (status == 'OTP_NOT_EXIST') {
      setState(() => isLoading = false);

      // initialiser les champs

      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "My Rawsur info",
          text: "OTP incorrect",
        ),
      );
    } else if (status == 'ERROR') {
      setState(() => isLoading = false);
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
    }
  }
}
