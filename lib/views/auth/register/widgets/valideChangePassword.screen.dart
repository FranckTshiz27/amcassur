import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/configs/constants.dart';
import 'package:amcassur/views/home/home_view.dart';
import 'package:flutter/material.dart';

class ValideChangePasswordScreen extends StatelessWidget {
  const ValideChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   foregroundColor: Colors.black,
      //   elevation: 0.0,
      //   centerTitle: true,
      // ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.only(left: 25, right: 25),
        decoration: const BoxDecoration(gradient: AppColors.APP_SCREENS),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .25),
              CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.verified_user,
                  size: 50,
                ),
                radius: 45,
              ),
              SizedBox(height: 10),
              Text(
                'Merci',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Votre mot de passe a été bien changé',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.MAIN_COLOR.withOpacity(.1),
                  borderRadius: appRadius,
                ),
                child: Text(
                  'Vous pouvez maintenant utiliser le nouveau mot de passe pour vous authentifier avant de déclarer vos sinistres ou pour consulter vos polices.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 50),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                    (route) => false,
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: appRadius,
                  ),
                  child: Center(
                    child: Text(
                      "Ok",
                      style: TextStyle(
                        color: Color.fromRGBO(18, 32, 123, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
