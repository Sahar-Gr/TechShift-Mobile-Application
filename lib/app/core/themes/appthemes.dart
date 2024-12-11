import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class AppThemes {
  static final GetStorage _box = GetStorage();
  static const _key = 'isDarkMode';

  static bool _loadThemeFromBox() => _box.read<bool>(_key) ?? false;
  static ThemeMode get theme =>
      _loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark;

  static void switchTheme() {
    _box.write(_key, Get.isDarkMode);
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
  }

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: const Color.fromARGB(255, 8, 86, 151),
    scaffoldBackgroundColor: Colors.blue.shade600,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue.shade600,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        fixedSize: const Size(300, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      // Vous pouvez ajouter d'autres styles ici
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        fixedSize: const Size(300, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      // Vous pouvez ajouter d'autres styles ici
    ),
  );
}
