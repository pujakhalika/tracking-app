import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarX(
        controller: SidebarXController(selectedIndex: 0, extended: true),
        items: const [
          SidebarXItem(icon: Icons.home, label: 'Home'),
          SidebarXItem(icon: Icons.search, label: 'Search'),
        ],
      ),
      body: const Center(child: Text('Your app body')),
    );
  }
}
