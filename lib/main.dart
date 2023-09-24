import 'package:besafe/app/backend/middleware/roam.dart';
import 'package:besafe/app/backend/middleware/wiredash_feedback.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:wiredash/wiredash.dart';
import 'app/backend/supabase/client/auth_client.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/routes.dart';
import 'package:get/get.dart';
import 'package:roam_flutter/roam_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
    debug: true,
  );

  OneSignal.initialize("a9b931a7-d385-42c5-86d2-dce904f0ce1d");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  Roam.initialize(publishKey: publishKey);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const BeSafeApp());
  });
}

class BeSafeApp extends StatelessWidget {
  const BeSafeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: wiredashID,
      secret: wiredashSecret,
      feedbackOptions: const WiredashFeedbackOptions(
        labels: [
          Label(
            id: 'label-yhoweugvvw',
            title: 'Bug',
          ),
          Label(
            id: 'label-yh3fsbogyb',
            title: 'Praise',
          ),
          Label(
            id: 'label-oymfmkpmkf',
            title: 'Improvement',
          ),
          Label(
            id: 'label-wsa3jez99w',
            title: 'Feature Request',
          ),
        ],
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: FlexColorScheme.light(
                blendLevel: 15,
                fontFamily: 'Yomogi',
                visualDensity: VisualDensity.comfortable,
                scheme: FlexScheme.wasabi)
            .toTheme,
        darkTheme: FlexColorScheme.dark(
                blendLevel: 10,
                fontFamily: 'Yomogi',
                visualDensity: VisualDensity.comfortable,
                scheme: FlexScheme.wasabi)
            .toTheme,
        themeMode: ThemeMode.system,
        initialRoute: /* '/home', */
            client.auth.currentUser == null ? '/splashscreen' : '/home',
        getPages: appRoutes(),
      ),
    );
  }
}
