import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(FontAwesomeIcons.bars),
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Open the drawer
        },
      ),
      title: const Text('Home'),
    );
  }
}
