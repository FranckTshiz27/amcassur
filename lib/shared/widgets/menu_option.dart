import 'package:amcassur/configs/preference.dart';
import 'package:amcassur/configs/preferencekeys.dart';
import 'package:amcassur/shared/constants/appcolors.dart';
import 'package:amcassur/shared/utils/compare_session_time.dart';
import 'package:amcassur/shared/utils/convert_token.dart';
import 'package:amcassur/views/auth/register/login.dart';
import 'package:amcassur/views/home/home_view.dart';
import 'package:amcassur/views/home/product_view.dart';
import 'package:amcassur/views/profile.dart';
import 'package:amcassur/views/sinistre/sinistre_view.dart';
import 'package:flutter/material.dart';

class MenuOption extends StatelessWidget {
  MenuOption(
      {super.key,
      label,
      required this.menuLabel,
      required this.iconData,
      required this.route});

  final String menuLabel;
  final IconData iconData;
  final String route;
  Map<String, dynamic>? token = null;
  String? token_pref = Preferences.get(PreferenceKeys.TOKEN);

  @override
  Widget build(BuildContext context) {
    token = ConvertToken.convert(token_pref);
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            color: AppColors.BACKGROUND_COLOR,
            // color: Color.fromARGB(172, 48, 73, 149),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.MAIN_COLOR,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              width: MediaQuery.of(context).size.width * 0.20,
              height: MediaQuery.of(context).size.width * 0.15,
              child: Icon(
                size: 40,
                iconData,
                color: AppColors.SECOND_COLOR,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              menuLabel,
              style: TextStyle(
                  color: AppColors.MAIN_COLOR,
                  fontWeight: FontWeight.w900,
                  fontSize: 16),
            )
          ],
        ),
      ),
      onTap: () {
        navigateTo(context);
      },
    );
  }

  navigateTo(context) {
    {
      Navigator.pop(context);
      if (SessionTime.isSessionValid()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(route: route),
          ),
        );
      } else if (token != null) {
        if (route == "profil") {}
        switch (route) {
          case 'sinistre':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SinistreView()),
            );
            break;
          case 'profile':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
            break;
          case 'home':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
            );
            break;
          case 'product':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductView()),
            );
            break;
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen(route: route)),
        );
      }
    }
  }
}
