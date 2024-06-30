import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class AppThemes {
  static final GetStorage _box = GetStorage();
  static const _key = 'isDarkMode';

  static bool _loadthemefrombox() => _box.read<bool>(_key) ?? false;
  static ThemeMode get theme =>
      _loadthemefrombox() ? ThemeMode.light : ThemeMode.dark;

  static void switchTheme() {
    _box.write(_key, Get.isDarkMode);
    Get.changeThemeMode(_loadthemefrombox() ? ThemeMode.light : ThemeMode.dark);
  }

  static get lightTheme => ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: Colors.blue,
      scaffoldBackgroundColor: Colors.blue.shade600,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade600, foregroundColor: Colors.white),
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
      ));

  static get darkTheme => ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.blue,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          fixedSize: const Size(300, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ));
}
