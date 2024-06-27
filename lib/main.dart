import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:applicationpfe/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDxX9FBxjAtZJt-l6OO2bKXy7buYl66WE8",
          appId: '1090766392131:android:0c75338b55624dd461fdf6',
          messagingSenderId: '1090766392131',
          projectId: 'ennakl-f27a2'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey,
          border: OutlineInputBorder(),
          hintStyle: TextStyle(color: Colors.white54),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.teal,
        ),
      ),
      themeMode: ThemeMode
          .light, // You can change this to ThemeMode.light or ThemeMode.system
      home: LoginScreen(),
    );
  }
}
