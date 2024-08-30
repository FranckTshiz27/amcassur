import 'package:amcassur/configs/preference.dart';
import 'package:amcassur/configs/preferencekeys.dart';
import 'package:amcassur/providers/register_data.dart';
import 'package:amcassur/shared/utils/compare_session_time.dart';
import 'package:amcassur/shared/utils/convert_token.dart';
import 'package:amcassur/views/auth/register/login.dart';
import 'package:amcassur/views/auth/register/register_step1.dart';
import 'package:amcassur/views/home/home_view.dart';
import 'package:amcassur/views/profile.dart';
import 'package:flutter/material.dart';
import '../../views/sinistre/sinistre_view.dart';
import '../constants/appcolors.dart';

class AmcDrawer extends StatelessWidget {
  const AmcDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? token = null;
    String? token_pref = Preferences.get(PreferenceKeys.TOKEN);
    token = ConvertToken.convert(token_pref);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.MAIN_COLOR,
                  AppColors.MAIN_COLOR.withOpacity(.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Text(
              'AMC-Assurance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: AppColors.MAIN_COLOR),
            title: Text(
              'Accueil',
              style: TextStyle(
                color: AppColors.MAIN_COLOR,
              ),
            ),
            onTap: () => Navigator.pushNamed(context, HomeView.routName),
            // onTap: () => Navigator.pop(context),
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.person,
          //     color: AppColors.MAIN_COLOR,
          //   ),
          //   title: Text(
          //     'Profil',
          //     style: TextStyle(color: AppColors.MAIN_COLOR),
          //   ),
          //   onTap: () => Navigator.pop(context),
          // ),
          ListTile(
              leading: Icon(
                Icons.warning_rounded,
                color: AppColors.MAIN_COLOR,
              ),
              title: Text(
                'Sinistre',
                style: TextStyle(color: AppColors.MAIN_COLOR),
              ),
              onTap: () {
                Navigator.pop(context);
                if (SessionTime.isSessionValid()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(route: "sinistre"),
                    ),
                  );
                } else if (token != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SinistreView()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen(route: "sinistre")),
                  );
                }
              }),
          ListTile(
              leading: Icon(
                Icons.person,
                color: AppColors.MAIN_COLOR,
              ),
              title: Text(
                'Profil',
                style: TextStyle(color: AppColors.MAIN_COLOR),
              ),
              onTap: () {
                Navigator.pop(context);
                if (SessionTime.isSessionValid()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(route: "profile"),
                    ),
                  );
                } else if (token != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(route: "profile"),
                    ),
                  );
                }
              }),
          SizedBox(height: MediaQuery.of(context).size.height * .455),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
              color: AppColors.SECOND_COLOR,
            ),
            title: Text(
              'Se déconecter',
              style: TextStyle(color: AppColors.SECOND_COLOR),
            ),
            onTap: () {
              RegisterData rigisterData = RegisterData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterStep1(
                      // rData: rigisterData,
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
