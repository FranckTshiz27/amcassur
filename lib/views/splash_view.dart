import 'package:amcassur/views/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import './home/home_view.dart';

import '../shared/constants/appcolors.dart';

DateTime date = DateTime.now();

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const routName = '/';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // DateTime date = DateTime.now();
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(
      Duration(seconds: 5),
      (() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
          // MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: AppColors.BACKGROUND_COLOR),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 180.0)),
                        Image.asset(
                          'assets/icons/amc-logo.PNG',
                          width: 220,
                          height: 220,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10.0)),
                        Text(
                          'Bienvenue',
                          style: TextStyle(
                            color: AppColors.TEXT_COLOR,
                            fontSize: 30,
                            // fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoActivityIndicator(
                      color: AppColors.TEXT_COLOR,
                      radius: 25,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 65.0)),
                    Text(
                      'version : ${_packageInfo.version}',
                      style: TextStyle(
                        color: AppColors.TEXT_COLOR,
                        fontSize: 10.0,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      "© AMC - Assurances ${date.year} - Tous les droits réservés.",
                      style: const TextStyle(
                        color: AppColors.TEXT_COLOR,
                        fontSize: 10.0,
                        decoration: TextDecoration.none,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
