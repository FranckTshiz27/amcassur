import 'package:flutter/material.dart';

Container CallButton(BuildContext context) => Container(
      // child: CircleAvatar(
      //   radius: MediaQuery.of(context).size.width * .079,
      //   backgroundColor: Colors.green,
      //   child: IconButton(
      //     color: Colors.white,
      //     onPressed: () async {
      //       Parametres? parametres = await ParametreService.getParametres();

      //       String? number = parametres?.phone_call_center;

      //       print("number : ${number}");

      //       await FlutterPhoneDirectCaller.callNumber(number!);
      //     },
      //     icon: Icon(Icons.phone),
      //   ),
      // ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //   Icon(Icons.phone, color: Colors.white),
      //   Text('Call center')
      // ]),
      child: GestureDetector(
        // onTap: () async {
        //   Parametres? parametres = await ParametreService.getParametres();

        //   String? number = parametres?.phone_call_center;

        // print("number : ${number}");

        // Parametres? parametres = await ParametreService.getParametres();

        // String? number = parametres?.phone_call_center;
        // if (number != null) {
        //   Preferences.set(PreferenceKeys.PHONE_CALL_CENTER, number);
        // } else {
        //   Preferences.set(PreferenceKeys.PHONE_CALL_CENTER, '474444');
        // }

        // await FlutterPhoneDirectCaller.callNumber(number!);
        // },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            // alignment: WrapAlignment.center,
            // runAlignment: WrapAlignment.center,
            // direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.call, color: Colors.white),
              Text(' '),
              Text(
                'Call center',
                style: TextStyle(color: Colors.white, fontSize: 13),
              )
            ],
          ),
        ),
      ),
    );
