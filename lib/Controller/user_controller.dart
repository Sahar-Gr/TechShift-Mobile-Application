import 'package:applicationpfe/Model/our_user.dart';
import 'package:applicationpfe/Services/user_database.dart';
import 'package:applicationpfe/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  get password => null;
  Future<bool> registerUser(
      BuildContext context, String email, String passwor) async {
    try {
      OurUser user = OurUser();
      UserCredential authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? u = authResult.user;
      if (u != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }
      if (authResult.user != null) {
        user.uid = authResult.user!.uid;
        user.email = authResult.user!.email;
        user.password = password;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginUser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential loginResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = loginResult.user;
      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }
      if (loginResult.user != null) {
        await UserDataBase().getUserInfo();
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
