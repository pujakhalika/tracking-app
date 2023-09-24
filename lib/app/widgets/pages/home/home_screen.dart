import 'package:about/about.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:besafe/app/backend/supabase/client/auth_client.dart';
import 'package:besafe/app/backend/supabase/services/auth_service.dart';
import 'package:besafe/app/constants/text_strings.dart';
import 'package:besafe/app/widgets/helper/layout/bottombar/tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:wiredash/wiredash.dart';
import '../../../controllers/intro/home/home_screen_controller.dart';
import 'package:sidebarx/sidebarx.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  final BottomNavController _bottomNavController =
      Get.put(BottomNavController());

  final List<Widget> pages = [
    const TrackingPage(),

    //* Add more
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleTextStyle: const TextStyle(fontFamily: 'OnePiece', fontSize: 60),
          title: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                tAppName,
                speed: const Duration(milliseconds: 300),
              ),
            ],
          ),
          leading: Builder(
              builder: (context) => IconButton(
                  icon: const Icon(Icons.widgets),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  })),
        ),
        body: Obx(() {
          return IndexedStack(
            index: _bottomNavController.selectedIndex.value,
            children: pages,
          );
        }),
        drawer: SidebarX(
          theme: const SidebarXTheme(),
          headerBuilder: (context, extended) {
            return const SizedBox(
              height: 60,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'MENU',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OnePiece',
                    ),
                  )),
            );
          },
          headerDivider: const Divider(
            height: 20,
            thickness: 2,
          ),
          footerDivider: const Divider(
            height: 20,
            thickness: 2,
          ),
          /* footerDivider: const SizedBox(height: 20), */
          footerBuilder: (context, extended) {
            return ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/supportscreen');
                  },
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.circleDollarToSlot),
                        SizedBox(height: 5),
                        Text(
                          tDonate,
                        ),
                        SizedBox(height: 30),
                      ]),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    await AuthService(client).signOut();
                  },
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.logout),
                        SizedBox(height: 5),
                        Text(
                          tLogout,
                        ),
                        SizedBox(height: 30),
                      ]),
                ),
              ],
            );
          },
          extendedTheme: const SidebarXTheme(
            width: 150,
          ),
          controller: SidebarXController(selectedIndex: 0, extended: true),
          items: [
/*             SidebarXItem(
              icon: Icons.account_box,
              label: 'Profile',
              onTap: () {
                Get.toNamed('/profilescreen');
              },
            ),
            SidebarXItem(
              icon: Icons.people,
              label: 'Contact',
              onTap: () {
                ///
              },
            ), */
            SidebarXItem(
              icon: Icons.settings,
              label: 'Settings',
              onTap: () {
                Get.toNamed('/settingsscreen');
              },
            ),
            SidebarXItem(
                icon: Icons.dark_mode,
                label: 'Theme',
                onTap: () {
                  Get.toNamed('/thememodescreen');
                }),
            SidebarXItem(
                icon: Icons.info,
                label: 'Info',
                onTap: () {
                  showAboutDialog(
                      context: context,
                      applicationName: tAppName,
                      applicationVersion: tAppVersion,
                      applicationLegalese: tAppCopyright,
                      children: const <Widget>[
                        MarkdownPageListTile(
                          filename: 'README.md',
                          title: Text('View Readme'),
                          icon: Icon(Icons.all_inclusive),
                        ),
                        MarkdownPageListTile(
                          filename: 'CHANGELOG.md',
                          title: Text('View Changelog'),
                          icon: Icon(Icons.view_list),
                        ),
                        MarkdownPageListTile(
                          filename: 'LICENSE.md',
                          title: Text('View License'),
                          icon: Icon(Icons.description),
                        ),
                        MarkdownPageListTile(
                          filename: 'CONTRIBUTING.md',
                          title: Text('Contributing'),
                          icon: Icon(Icons.share),
                        ),
                        MarkdownPageListTile(
                          filename: 'CODE_OF_CONDUCT.md',
                          title: Text('Code of conduct'),
                          icon: Icon(Icons.sentiment_satisfied),
                        ),
                        LicensesPageListTile(
                          title: Text('Open source Licenses'),
                          icon: Icon(Icons.favorite),
                        ),
                      ],
                      applicationIcon: const SizedBox(
                        width: 100,
                        height: 100,
                        child: Image(
                          image: AssetImage('assets/logo/logo-1.jpg'),
                        ),
                      ));
                  /* Get.to(() => const Page6()); */
                }),
            SidebarXItem(
                icon: Icons.feedback,
                label: 'Feedback',
                onTap: () {
                  Wiredash.of(context).show(
                    inheritMaterialTheme: true,
                  );
                }),
            SidebarXItem(
                icon: Icons.thumb_up,
                label: 'Rate BeSafe',
                onTap: () {
                  Wiredash.of(context).showPromoterSurvey(
                    force: true,
                    inheritMaterialTheme: true,
                  );
                }),
/*             SidebarXItem(
                icon: Icons.share,
                label: 'Share',
                onTap: () {
                  Get.to(() => const Page2());
                }), */
          ],
        ),
        bottomNavigationBar: Obx(() {
          return ConvexAppBar(
            items: const [
              TabItem(icon: Icons.share_location),
            ],
            initialActiveIndex: _bottomNavController.selectedIndex.value,
            backgroundColor: const Color(0xFF738625),
            onTap: (index) {
              _bottomNavController.selectItem(index);
            },
          );
        }),
      ),
    );
  }
}








