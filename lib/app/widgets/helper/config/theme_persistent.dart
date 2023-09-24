import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;

  ThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _initializeThemeMode();
  }

  Future<void> _initializeThemeMode() async {
    final themeMode = await _getSavedThemeMode();
    if (themeMode != null) {
      _themeMode.value = themeMode;
      Get.changeThemeMode(themeMode);
    }
  }

  Future<ThemeMode?> _getSavedThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final int? themeModeIndex = prefs.getInt('theme_mode');
    if (themeModeIndex != null &&
        themeModeIndex >= 0 &&
        themeModeIndex < ThemeMode.values.length) {
      return ThemeMode.values[themeModeIndex];
    }
    return null;
  }

  Future<void> toggleTheme() async {
    final newThemeMode =
        _themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _themeMode.value = newThemeMode;
    Get.changeThemeMode(newThemeMode);
    await _saveThemeMode(newThemeMode);
  }

  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', themeMode.index);
  }
}
