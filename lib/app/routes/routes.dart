import 'package:besafe/app/widgets/helper/layout/sidebar/changemail/change_email.dart';
import 'package:besafe/app/widgets/helper/layout/sidebar/changepassword/update_password_screen.dart';
import 'package:besafe/app/widgets/helper/layout/sidebar/localauth/localauth.dart';
import 'package:besafe/app/widgets/helper/layout/sidebar/profile_screen.dart';
import 'package:besafe/app/widgets/helper/layout/sidebar/settings_screen.dart';
import 'package:besafe/app/widgets/helper/layout/sidebar/support_screen.dart';
import 'package:besafe/app/widgets/helper/layout/sidebar/theme_mode_screen.dart';
import 'package:besafe/app/widgets/pages/home/home_screen.dart';
import 'package:besafe/app/widgets/helper/layout/sidebar/changepassword/password_recovery_screen.dart';
import 'package:besafe/app/widgets/pages/splash/splash_screen.dart';
import 'package:besafe/app/widgets/pages/onboarding/onboarding_screen.dart';
import 'package:besafe/app/widgets/pages/welcome/welcome_screen.dart';
import 'package:besafe/app/widgets/pages/login/login_screen.dart';
import 'package:besafe/app/widgets/pages/login/signup_screen.dart';
import 'package:besafe/app/widgets/pages/login/verify_screen.dart';
import 'package:get/get.dart';

appRoutes() => [
      GetPage(
        name: '/splashscreen',
        page: () => SplashScreen(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/onboarding',
        page: () => const OnBoardingScreen(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/welcome',
        page: () => const WelcomeScreen(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/login',
        page: () => LoginScreen(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/signup',
        page: () => SignupScreen(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/updatepassword',
        page: () => UpdatePasswordScreen(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/passwordrecovery',
        page: () => PasswordRecoveryScreen(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/verifyscreen',
        page: () => VerifyScreen(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/home',
        page: () => HomeScreen(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/supportscreen',
        page: () => const SupportScreen(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/thememodescreen',
        page: () => ThemeModeScreen(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/profilescreen',
        page: () => ProfileScreen(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/settingsscreen',
        page: () => const SettingScreen(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/localauth',
        page: () => const LocalAuth(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/changeemail',
        page: () => ChangeEmailScreen(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ];
