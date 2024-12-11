import 'dart:developer';

import 'package:applicationpfe/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:applicationpfe/app/routes/app_routes.dart';

class SigininController extends GetxController with StateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = true;
  bool rememberMe = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Assure-toi qu'il est unique

  @override
  void onInit() {
    // Clear the email and password fields on initialization
    emailController.clear();
    passwordController.clear();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update(["password"]);
  }

  void toggleRememberMe(bool? v) {
    rememberMe = !rememberMe;
    update(["rememberMe"]);
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      if (formKey.currentState!.validate()) {
        change(null, status: RxStatus.loading());
        UserCredential result = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        User? user = result.user;
        if (user != null) {
          Get.offAllNamed(Routes.HOME_MENU);
        }
      }
    } catch (e) {
      log("Error signing in: $e");
    } finally {
      change(null, status: RxStatus.success());
    }
  }
}