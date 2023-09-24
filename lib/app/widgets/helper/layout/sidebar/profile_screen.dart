import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // User card
            BigUserCard(
              userName: "",
              userProfilePic: const AssetImage('assets/logo/logo-1.jpg'),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                  withBackground: true,
                  borderRadius: 50,
                  backgroundColor: Colors.yellow[600],
                ),
                title: "Modify",
                subtitle: "Tap to change your data",
                onTap: () {},
              ),
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.question_answer,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'FAQ',
                  subtitle: "Learn more about BeSafe App",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.password,
                  title: "Change Your Password",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.delete,
                  title: "Delete Your Account",
                  titleStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
