import 'dart:developer';

import 'package:applicationpfe/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigininController extends GetxController with StateMixin {
  final emailController = TextEditingController(),
      passwordController = TextEditingController();
  bool isPasswordVisible = true;
  bool rememberMe = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? checkEmailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? checkPwdValidation(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter some text';
      }

      if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
    }
    return null;
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update(["password"]);
  }

  void toggleRememberMe(bool? v) {
    rememberMe = !rememberMe;
    update(["rememberMe"]);
  }

  // Sign in with email and password
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
          Get.offAllNamed(Routes.HOME);
        }
      }
    } catch (e) {
      log("Error signing in: $e");
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      log("Error signing up: $e");
      return null;
    }
  }
}
