import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/configs/constants.dart';
import 'package:amcassur/views/home/home_view.dart';
import 'package:flutter/material.dart';

class ValideResetPasswordScreen extends StatelessWidget {
  const ValideResetPasswordScreen({Key? key}) : super(key: key);

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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'Votre mot de passe a été bien réinitialisé',
                style: TextStyle(fontSize: 16),
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
                  'Vous pouvez maintenant l\'utiliser pour vous authentifier avant de déclarer vos sinistres ou pour consulter vos polices.',
                  style: TextStyle(fontSize: 16),
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
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.LIGHTER_BLUE,
                    borderRadius: appRadius,
                  ),
                  child: Center(
                    child: Text(
                      "Ok",
                      style: TextStyle(
                        color: Colors.white,
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
