import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SettingsGroup(
              settingsGroupTitle: "Security and Privacy",
              items: [
                SettingsItem(
                  onTap: () {
                    Get.toNamed('/localauth');
                  },
                  icons: Icons.fingerprint,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.cyan,
                  ),
                  title: 'Security',
                  subtitle: "Lock BeSafe to improve your privacy",
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Frequency Asked Questions",
              items: [
                SettingsItem(
                  onTap: () {
                    Get.toNamed('/faqscreen');
                  },
                  icons: Icons.question_answer,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'FAQ',
                  subtitle: "Learn more about BeSafe",
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {
                    Get.toNamed('/updatepassword');
                  },
                  icons: Icons.password,
                  title: "Change Your Password",
                ),
                SettingsItem(
                  onTap: () {
                    Get.toNamed('/changeemail');
                  },
                  icons: Icons.change_circle,
                  title: "Change Your Email",
                ),
/*                 SettingsItem(
                  onTap: () {},
                  icons: Icons.delete,
                  title: "Delete Your Account",
                  titleStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ), */
              ],
            ),
          ],
        ),
      ),
    );
  }
}
