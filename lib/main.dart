import 'package:amcassur/configs/environment.dart';
import 'package:amcassur/configs/preference.dart';
import 'package:amcassur/providers/register_data_provider.dart';
import 'package:amcassur/views/home/home_view.dart';
import 'package:amcassur/views/home/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:amcassur/shared/constants/appcolors.dart';
import 'providers/product_provider.dart';
import 'views/auth/login.dart';
import 'views/home/widgets/product_details.dart';
import 'views/sinistre/sinistre_view.dart';
import 'views/splash_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);
  await Preferences.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ProductProvider productProvider = ProductProvider();
  RegisterDataProvider registerDataProvider = RegisterDataProvider();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: productProvider),
        ChangeNotifierProvider.value(value: registerDataProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AMC - Assurances',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.MAIN_COLOR),
          primaryColor: AppColors.MAIN_COLOR,
          primaryColorLight: AppColors.SECOND_COLOR,
          dialogBackgroundColor: AppColors.BACKGROUND_COLOR,
          secondaryHeaderColor: AppColors.TEXT_COLOR,
          dividerColor: AppColors.SECOND_COLOR,
          useMaterial3: true,
        ),
        // home: const SplashView(),
        initialRoute: SplashView.routName,
        routes: {
          SplashView.routName: (_) => const SplashView(),
          HomeView.routName: (_) => HomeView(),
          LoginView.routName: (_) => const LoginView(),
          ProductDetail.routName: (_) => const ProductDetail(),
          SinistreView.routName: (_) => const SinistreView(),
          ProductView.routName: (_) => const ProductView(),
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('fr')],
        locale: const Locale('fr', ''),
      ),
    );
  }
}
