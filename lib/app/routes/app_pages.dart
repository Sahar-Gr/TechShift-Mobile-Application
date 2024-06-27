import 'package:get/get.dart';

import '../middlewares/signin_middlewares.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/siginin/bindings/siginin_binding.dart';
import '../modules/siginin/views/siginin_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.SIGININ,
      page: () => const SigininView(),
      binding: SigininBinding(),
      middlewares: [SigninMiddleware()],
    ),
  ];
}
