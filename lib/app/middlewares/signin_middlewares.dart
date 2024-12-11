import 'package:applicationpfe/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:applicationpfe/app/routes/app_routes.dart';
class SigninMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (FirebaseAuth.instance.currentUser != null) {
      return const RouteSettings(name: Routes.HOME_MENU);  // Modifié
    }
    return null;
  }
}
