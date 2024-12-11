
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'app/core/themes/appthemes.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/register/controllers/register_controller.dart';
import 'app/modules/siginin/controllers/siginin_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  // Enregistrement des contrôleurs
  Get.put(SigininController());
  Get.put(HomeController());
  Get.put(RegisterController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Ennakl",
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: AppThemes.theme,
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
      // Ajout des localisations matérielles
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // Langue anglaise
        const Locale('fr', 'FR'), // Langue fr
        // Ajoutez d'autres locales si nécessaire
      ],
    );
  }
}
