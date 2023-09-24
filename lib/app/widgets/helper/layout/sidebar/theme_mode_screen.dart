import 'package:besafe/app/widgets/helper/config/theme_persistent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class ThemeModeScreen extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
        actions: [
          Obx(() => AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: FlutterSwitch(
                  inactiveIcon: const Icon(
                    FontAwesomeIcons.sun,
                  ),
                  activeIcon: const Icon(
                    FontAwesomeIcons.moon,
                  ),
                  key: ValueKey<bool>(
                      _themeController.themeMode == ThemeMode.dark),
                  value: _themeController.themeMode == ThemeMode.dark,
                  onToggle: (value) {
                    if (value !=
                        (_themeController.themeMode == ThemeMode.dark)) {
                      _themeController.toggleTheme();
                    }
                  },
                  activeColor: const Color(0xFF738625),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Icon(_themeController.themeMode == ThemeMode.light
                  ? FontAwesomeIcons.sun
                  : FontAwesomeIcons.moon)),
              const SizedBox(width: 8),
              Obx(() => Text(_themeController.themeMode == ThemeMode.light
                  ? 'LIGHT MODE'
                  : 'DARK MODE')),
            ],
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TOGGLE LIGHT OR DARK MODE WHAT YOU WANT ON THE TOP',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'HinaMincho',
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
