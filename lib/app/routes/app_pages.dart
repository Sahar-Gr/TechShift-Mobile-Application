import 'package:applicationpfe/app/modules/home/widgets/ecran.dart';
import 'package:applicationpfe/app/modules/splash/views/splash_view.dart';
import 'package:applicationpfe/app/routes/app_routes.dart';
import 'package:get/get.dart';
import '../middlewares/signin_middlewares.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_menu_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/siginin/bindings/siginin_binding.dart';
import '../modules/siginin/views/siginin_view.dart';
import '../modules/home/views/moteur_view.dart';
import '../modules/home/views/bv_view.dart';
import '../modules/home/views/animation_view.dart';

// ignore_for_file: constant_identifier_names

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
    ),
    GetPage(
      name: Routes.HOME_MENU,
      page: () => HomeMenuView(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.SIGININ,
      page: () => SigininView(),
      binding: SigininBinding(),
      middlewares: [SigninMiddleware()],
    ),
    GetPage(
      name: Routes.MOTEUR,
      page: () => MoteurView(),
    ),
    GetPage(
      name: Routes.BV,
      page: () => BvView(),
    ),
    GetPage(
      name: Routes.ANIMATION,
      page: () => AnimationView(),
    ),
    GetPage(
      name: Routes.CAR_POSITION, // Nouvelle route pour la page de position
      page: () => CarPositionPage(), // Nouvelle page
    ),
  ];
}
