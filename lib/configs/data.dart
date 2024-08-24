// import 'package:flutter/material.dart';
// import 'package:myrawsur/components/mypolicies/auto/mypolicy.screens.dart';
// import 'package:myrawsur/components/products/details/assurance_ind_accident.dart';
// import 'package:myrawsur/components/products/details/assurance_kimia.dart';
// import 'package:myrawsur/components/products/details/assurance_mr_habitation.dart';
// import 'package:myrawsur/components/products/details/assurance_securis.dart';

// import '../components/app/bottom_bar.dart';
// import '../components/products/details/assurance_auto.dart';
// import '../components/products/details/assurance_voyage.dart';

// const Color _inactiveColor = Colors.grey;

// class Data {
//   static const List<Map<String, String>> carousels = [
//     {
//       'url': 'assets/images/carousels/rawsur_bizcongo20193010.jpg',
//     },
//     // {
//     //   'url': 'assets/images/carousels/RAWSUR-696x464.jpg',
//     // },
//     {
//       'url': 'assets/images/carousels/rawsur_moncongo_12.jpeg',
//     },
//     {
//       'url': 'assets/images/carousels/R.jpg',
//     },
    // {
    //   'url': 'assets/images/carousels/rawsur_moncongo_10.jpeg',
    // },
    // {
    //   'url': 'assets/images/carousels/1663664139253.jpg',
    // },
    // {
    //   'url': 'assets/images/carousels/RAWSUR_MEN.jpg',
    // },
    // {
    //   'url': 'assets/images/carousels/rawsur_moncongo_7.jpeg',
    // },
  //   {
  //     'url': 'assets/images/carousels/E2TRZnAWUAAh3HK.jpg',
  //   },
  //   {
  //     'url': 'assets/images/carousels/RAWSUR_WOMEN.jpg',
  //   },
  //   // {
  //   //   'url': 'assets/images/carousels/rawsur_moncongo_16.jpeg',
  //   // },
  // ];

  // static const List<Map<String, dynamic>> carousels_products = [
  //   {
  //     // 'url': 'assets/refonte/autosur-image.png',
  //     'url': 'assets/products/AUTOSUR.jpg',
  //     'url-image': 'assets/autosur_new_logo.png',
  //     'route': AssuranceAuto(),
  //     'idcat': 4,
  //   },
  //   {
  //     // 'url': 'assets/refonte/gosur-image.png',
  //     'url': 'assets/products/GOSUR.jpg',
  //     'url-image': 'assets/logo_gosur_new.png',
  //     'route': AssuranceVoyage(),
  //     'idcat': 5,
  //   },
  //   {
  //     // 'url': 'assets/refonte/accident-images.png',
  //     'url': 'assets/products/INDIVIDUELLE ACCIDENT.jpg',
  //     'url-image': 'assets/Logo-IA.png',
  //     'route': AssuranceIndAccident(),
  //     'idcat': 0,
  //   },
  //   {
  //     // 'url': 'assets/refonte/habitasur-image.png',
  //     'url': 'assets/products/HABITASUR.jpg',
  //     'url-image': 'assets/Logo-Habitasur.png',
  //     'route': const AssurranceMultiRiskHabitat(),
  //     'idcat': 0,
  //   },
  //   {
  //     'url': 'assets/refonte/securis.png',
  //     'url-image': 'assets/logo_securis.png',
  //     'route': const AssuranceSecuris(),
  //     'idcat': 3,
  //   },
  //   {
  //     // 'url': 'assets/refonte/kimia.png',
  //     'url': 'assets/products/KIMIA.jpg',
  //     'url-image': 'assets/logo-kimia.png',
  //     'route': const AssuranceKimia(),
  //     'idcat': 2,
  //   },
  // ];

  // static const List<Map<String, dynamic>> type_policys = [
    // {
    //   'title': 'HABITASUR',
    //   'url-image': 'assets/Logo-Habitasur.png',
    //   'route': null,
    // },
  //   {
  //     'title': 'EDUCASSUR',
  //     'url-image': 'assets/educassur.png',
  //     // 'route': null,
  //     'code': '205',
  //     'route': MyPoliciesScreens(
  //       productId: "1",
  //     ),
  //   },
  //   {
  //     'title': 'KIMIA',
  //     'url-image': 'assets/logo-kimia.png',
  //     'route': MyPoliciesScreens(
  //       productId: "2",
  //     ),
  //     'code': '202'
  //   },
  //   {
  //     'title': 'SECURIS',
  //     'url-image': 'assets/logo_securis.png',
  //     'route': MyPoliciesScreens(
  //       productId: "3",
  //     ),
  //     'code': '225'
  //   },
  //   {
  //     'title': 'AUTOSUR',
  //     'url-image': 'assets/autosur_new_logo.png',
  //     'route': MyPoliciesScreens(
  //       productId: "4",
  //     ),
  //     'code': '315'
  //   },
  //   {
  //     'title': 'GOSUR',
  //     'url-image': 'assets/logo_gosur_new.png',
  //     'code': '140',
  //     'route': MyPoliciesScreens(
  //       productId: "5",
  //     ),
  //   },
  // ];

  // static List<Map<String, dynamic>> services = [
  //   {
  //     'title': 'Nos produits',
  //     'route': Products(),
  //     'icone': Icon(Icons.feed_outlined, color: Colors.white, size: 30),
  //     'state': true
  //   },
  //   {
  //     'title': 'Declaration sinistre',
  //     // 'route': const Sinistre(),
  //     'route': (Preferences.get(PreferenceKeys.TOKEN)!.isNotEmpty)
  //         ? const SinistreScreen()
  //         : LoginScreen(),
  //     'icone': Icon(Icons.notifications, color: Colors.white, size: 30),
  //     'state': true
  //   },
  //   {
  //     'title': 'Mes polices',
  //     'route': const MyPoliciesScreens(),
  //     'icone': Icon(Icons.policy_sharp, color: Colors.white, size: 30),
  //     'state': true
  //   },
  //   {
  //     'title': 'Mon profil',
  //     'route': ProfileScreen(),
  //     'icone':
  //         Icon(Icons.account_circle_rounded, color: Colors.white, size: 30),
  //     'state': true
  //   },
  // ];

//   static const List<Map<String, dynamic>> productList = [
//     {
//       'name': 'Assurance Automobile',
//       'iconPath': 'assets/images/automobile.png',
//       'route': AssuranceAuto(),
//       'state': true
//     },
//     {
//       'name': 'Assurance Voyage',
//       'iconPath': 'assets/images/voyages.png',
//       'route': AssuranceVoyage(),
//       'state': true
//     },
//     {
//       'name': 'Assurance Multirisques Habitation',
//       'iconPath': 'assets/images/multi_risque_habitation.png',
//       'route': const AssurranceMultiRiskHabitat(),
//       'state': true
//     },
//     {
//       'name': 'Assurance Individuelle Accidents',
//       'iconPath': 'assets/images/individual.png',
//       'route': AssuranceIndAccident(),
//       'state': true
//     },
//     {
//       'name': 'Assurance Vie KIMIA',
//       'iconPath': 'assets/images/kimia.png',
//       'route': const AssuranceKimia(),
//       'state': true
//     },
//     {
//       'name': 'Assurance Vie SECURIS',
//       'iconPath': 'assets/images/vie.png',
//       'route': AssuranceSecuris(),
//       'state': true
//     },
//   ];

//   static const List<Map<String, dynamic>> assurencePros = [
//     {
//       'name': 'Assurance Automobile',
//       'iconPath': 'assets/images/automobile.png',
//       'route': AssuranceAuto(),
//       'state': false
//     },
//     {
//       'name': 'Assurance Voyage',
//       'iconPath': 'assets/images/voyages.png',
//       'route': AssuranceAuto(),
//       'state': false
//     },
//     {
//       'name': 'Assurance Multirisques Professionnelle',
//       'iconPath': 'assets/images/multi_risque_pro.png',
//       'route': AssuranceAuto(),
//       'state': false
//     },
//     {
//       'name': 'Assurance tous risques Chantier',
//       'iconPath': 'assets/images/tout_risque_chantier.png',
//       'route': AssuranceAuto(),
//       'state': false
//     },
//     {
//       'name': 'Assurance Transport de Marchandises',
//       'iconPath': 'assets/images/transport_marchandise.png',
//       'route': AssuranceAuto(),
//       'state': false
//     },
//     {
//       'name': 'Assurance Responsabilité Civile Professionnelle',
//       'iconPath': 'assets/images/rc.png',
//       'route': AssuranceAuto(),
//       'state': false
//     },
//     {
//       'name': 'Assurance Collective',
//       'iconPath': 'assets/images/ass_colective.png',
//       'route': AssuranceAuto(),
//       'state': false
//     },
//   ];

//   static List<BottomNavyBarItem> bottomBars = [
//     BottomNavyBarItem(
//       icon: Icons.home_filled,
//       title: Text(
//         'Accueil',
//         style: TextStyle(color: Colors.white, fontSize: 14),
//       ),
//       activeColor: Colors.white,
//       inactiveColor: _inactiveColor,
//       textAlign: TextAlign.center,
//     ),
//     BottomNavyBarItem(
//       icon: Icons.policy_sharp,
//       title: Text(
//         'Polices',
//         style: TextStyle(color: Colors.white, fontSize: 14),
//       ),
//       activeColor: Colors.white,
//       inactiveColor: _inactiveColor,
//       textAlign: TextAlign.center,
//     ),
//     BottomNavyBarItem(
//       icon: Icons.account_circle,
//       title: Text(
//         'Profile ',
//         style: TextStyle(color: Colors.white, fontSize: 14),
//       ),
//       activeColor: Colors.white,
//       inactiveColor: _inactiveColor,
//       textAlign: TextAlign.center,
//     ),
//     // BottomNavyBarItem(
//     //   icon: Icons.settings,
//     //   title: Text(
//     //     'Parametre',
//     //     style: GoogleFonts.roboto(color: Colors.white, fontSize: 14),
//     //   ),
//     //   activeColor: Colors.white,
//     //   inactiveColor: _inactiveColor,
//     //   textAlign: TextAlign.center,
//     // ),
//   ];
//   static List<String> specialCaracteres = [
//     "'",
//     "²",
//     "&",
//     "#",
//     "*",
//     "/",
//     "-",
//     "+",
//     ".",
//     "{",
//     "}",
//     "(",
//     ")",
//     "_",
//     "ç",
//     "=",
//     "£",
//     "%",
//     "¨",
//     "^",
//     "¤",
//     "!",
//     "?",
//     ";",
//     ":",
//     "@",
//     "\\",
//     ",",
//     "<",
//     ">",
//     "\$",
//     "[",
//     "]",
//     "\"",
//     "|",
//     "`",
//     "~",
//     "§",
//     "«",
//     "¼",
//     "½",
//     "¬",
//     "⌐",
//     "¿",
//     "º",
//     "æ",
//     "Æ",
//     "¥",
//     "₧",
//     "¡",
//     "«",
//     "»",
//     "α",
//     "ß",
//     "π",
//     "Σ",
//     "σ",
//     "µ",
//     "τ",
//     "Ω",
//     "δ",
//     "∞",
//     "φ",
//     "ε",
//     "∩",
//     "±",
//     "≥",
//     "≤",
//     "÷",
//     "≈",
//     "°",
//     "√",
//     "ⁿ",
//     "",
//   ];
// }
