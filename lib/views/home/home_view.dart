import 'package:amcassur/configs/preference.dart';
import 'package:amcassur/configs/preferencekeys.dart';
import 'package:amcassur/shared/constants/appcolors.dart';
import 'package:amcassur/shared/utils/compare_session_time.dart';
import 'package:amcassur/shared/utils/convert_token.dart';
import 'package:amcassur/shared/widgets/drawer.dart';
import 'package:amcassur/shared/widgets/menu_option.dart';
import 'package:amcassur/views/auth/register/login.dart';
import 'package:amcassur/views/sinistre/sinistre_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  static const routName = '/home';
  Map<String, dynamic>? token = null;
  String? token_pref = Preferences.get(PreferenceKeys.TOKEN);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            " Accueil",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.LIGHTER_BLUE,
            ),
          ),
        ),
      ),
      drawer: AmcDrawer(),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Padding(padding: EdgeInsets.only(top: 180.0)),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color.fromARGB(107, 48, 73, 149),
                  borderRadius: BorderRadius.circular(5)),
              child: Image.asset(
                'assets/icons/amc-logo.PNG',
                width: 520,
                height: 240,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuOption(
                  menuLabel: "Accueil",
                  iconData: Icons.home,
                  route: "home",
                ),
                SizedBox(
                  width: 20,
                ),
                MenuOption(
                  route: "sinistre",
                  menuLabel: "Sinistre",
                  iconData: Icons.warning_rounded,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuOption(
                  route: "profile",
                  menuLabel: "Profil",
                  iconData: Icons.person,
                ),
                SizedBox(
                  width: 20,
                ),
                MenuOption(
                  route: "product",
                  menuLabel: "Produits",
                  iconData: Icons.production_quantity_limits,
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
