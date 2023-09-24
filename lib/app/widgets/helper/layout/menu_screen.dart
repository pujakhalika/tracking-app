import 'package:flutter/material.dart';

class DrawerMenuScreen extends StatelessWidget {
  const DrawerMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add your drawer content here
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Add your navigation logic here for the Settings screen
              Navigator.pop(context); // Close the drawer after navigation
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {
              // Add your navigation logic here for the Help screen
              Navigator.pop(context); // Close the drawer after navigation
            },
          ),
        ],
      ),
    );
  }
}
