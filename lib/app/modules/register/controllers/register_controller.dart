import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:applicationpfe/app/routes/app_routes.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController with StateMixin {
  final emailController = TextEditingController(),
      passwordController = TextEditingController(),
      reenterpasswordController = TextEditingController();
  bool isPasswordVisible = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update(["password"]);
  }

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  Future<void> signUpWithEmailAndPassword() async {
    try {
      if (formKey.currentState!.validate()) {
        change(null, status: RxStatus.loading());
        UserCredential result = await _auth.createUserWithEmailAndPassword(
            email: emailController.text,
            password: reenterpasswordController.text);
        User? user = result.user;
        if (user != null) {
          Get.offAllNamed(Routes.HOME_MENU); // Modifié
        }
      }
    } catch (e) {
      log("Error signing up: $e");
    } finally {
      change(null, status: RxStatus.success());
    }
  }
}
