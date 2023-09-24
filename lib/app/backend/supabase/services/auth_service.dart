/* import 'package:besafe/app/backend/supabase/client/auth_client.dart'; */
import 'package:besafe/app/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService(this.client);

  var authRedirectUri = 'besafe://callback/';

  final SupabaseClient client;

//* SignUp Method
  Future<void> signUp(String name, String email, String password) async {
    try {
      final AuthResponse res = await client.auth.signUp(
        data: {
          'name': name,
        },
        email: email,
        password: password,
        emailRedirectTo: kIsWeb ? null : authRedirectUri,
      );
      await client.from('users').insert({
        'name': name,
        'email': email,
        'created_at': DateTime.now().toIso8601String(),
        'id': res.user!.id
      });

      // * Show loading dialog on successful sign-up
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitSpinningLines(
                  duration: Duration(milliseconds: 2000),
                  color: Colors.cyan,
                  size: 50.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  'LOADING...',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      // * Delay execution for 3 seconds
      await Future.delayed(const Duration(seconds: 3));

      // * Close loading dialog on successful sign-up
      Get.back();

      //* Motion toast message
      MotionToast.success(
        title: const Text("ALMOST THERE!"),
        description: const Text(
            "Thanks for signing up, now check your email for verification."),
        position: MotionToastPosition.top,
      ).show(Get.context!);

      client.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;

        if (event == AuthChangeEvent.signedIn && session != null) {
          Get.offAllNamed('/home');
        }
      });
    } catch (e) {
      String errorMessage = "An error occurred. Please try again.";

      if (e is AuthException) {
        errorMessage = e.message;
      }
      //* Show error toast message
      MotionToast.error(
        title: const Text("ERROR!"),
        description: Text(errorMessage),
        position: MotionToastPosition.top,
      ).show(Get.context!);
    }
  }

  //* SignIn Method
  Future<void> signIn(String email, String password) async {
    try {
      await client.auth.signInWithPassword(
        password: password,
        email: email,
      );

      // * Show loading dialog on successful sign-in
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitSpinningLines(
                  duration: Duration(milliseconds: 2000),
                  color: Colors.cyan,
                  size: 50.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  'LOADING...',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
      // * Delay execution for 3 seconds
      await Future.delayed(const Duration(seconds: 3));

      // * Close loading dialog on successful sign-in
      Get.back();

      MotionToast.info(
        title: const Text("INFO!"),
        description:
            const Text("Before login we need verify your identity first "),
        position: MotionToastPosition.top,
      ).show(Get.context!);
      client.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;

        if (event == AuthChangeEvent.signedIn && session != null) {
          Get.offAllNamed('/home');
        }
      });
    } catch (e) {
      String errorMessage = "An error occurred. Please try again.";

      if (e is AuthException) {
        errorMessage = e.message;
      }
      //* Show error toast message
      MotionToast.error(
        title: const Text("ERROR!"),
        description: Text(errorMessage),
        position: MotionToastPosition.top,
      ).show(Get.context!);
    }
  }

  //* SignOut Method
  Future<void> signOut() async {
    try {
      kDefaultDialog(
        "Sign Out",
        "Are you sure you want to sign out?",
        onYesPressed: () async {
          await client.auth.signOut();
          Get.deleteAll(force: true);
          Get.offAllNamed('/login');
          client.auth.onAuthStateChange.listen((data) {
            final AuthChangeEvent event = data.event;
            final Session? session = data.session;
            if (event == AuthChangeEvent.signedOut && session != null) {
              Get.toNamed('/login');
            }
          });
        },
      );
    } catch (e) {
      String errorMessage = "An error occurred. Please try again.";
      if (e is AuthException) {
        errorMessage = e.message;
      }
      //* Show error toast message
      MotionToast.error(
        title: const Text("ERROR!"),
        description: Text(errorMessage),
        position: MotionToastPosition.top,
      ).show(Get.context!);
    }
  }

  //* OTP Verification
  Future<void> sendVerify(String email) async {
    try {
      final AuthResponse res = await client.auth.verifyOTP(
        email: 'email',
        token: 'token',
        type: OtpType.email,
        redirectTo: authRedirectUri,
      );

      if (res.session != null) {
        Get.offAllNamed('/home');
      } else {
        Get.offAllNamed('/login');
      }
    } catch (e) {
      String errorMessage = "An error occurred. Please try again.";
      if (e is AuthException) {
        errorMessage = e.message;
      }

      //* Show error toast message
      MotionToast.error(
        title: const Text("ERROR!"),
        description: Text(errorMessage),
        position: MotionToastPosition.top,
      ).show(Get.context!);
    }
  }

  //* Reset Password Method
  Future<void> resetPassword(String email) async {
    try {
      await client.auth.resetPasswordForEmail(
        email,
        redirectTo: kIsWeb ? null : authRedirectUri,
      );

      //* Show loading dialog on successful reset
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitSpinningLines(
                  duration: Duration(milliseconds: 1000),
                  color: Colors.cyan,
                  size: 50.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  'LOADING...',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
      //* Delay execution for 3 seconds
      await Future.delayed(const Duration(seconds: 3));

      //* Close loading dialog on successful reset
      Get.back();

      //* Show success toast message
      MotionToast.success(
        title: const Text("SUCCESS!"),
        description: const Text("Password reset email sent"),
        position: MotionToastPosition.top,
      ).show(Get.context!);
      client.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;
        if (event == AuthChangeEvent.passwordRecovery && session != null) {
          Get.offAllNamed('/passwordrecovery');
        }
      });
    } catch (e) {
      String errorMessage = "An error occurred. Please try again.";

      if (e is AuthException) {
        errorMessage = e.message;
      }

      //* Show error toast message
      MotionToast.error(
        title: const Text("ERROR!"),
        description: Text(errorMessage),
        position: MotionToastPosition.top,
      ).show(Get.context!);
    }
  }

  //* Password Recovery
  Future<void> recoverPassword(String password) async {
    try {
      final UserResponse res = await client.auth.updateUser(
        UserAttributes(
          password: 'New Password',
        ),
      );
      await client.from('users').insert(
          {'created_at': DateTime.now().toIso8601String(), 'id': res.user!.id});

      //* Show loading dialog on successful reset
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitSpinningLines(
                  duration: Duration(milliseconds: 1000),
                  color: Colors.cyan,
                  size: 50.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  'LOADING...',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
      //* Delay execution for 3 seconds
      await Future.delayed(const Duration(seconds: 3));

      //* Close loading dialog on successful reset
      Get.back();

      //* Show success toast message
      MotionToast.success(
        title: const Text("SUCCESS!"),
        description: const Text("Password reset email sent"),
        position: MotionToastPosition.top,
      ).show(Get.context!);

      client.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;
        if (event == AuthChangeEvent.passwordRecovery && session != null) {
          Get.offAllNamed('/login');
        }
      });
    } catch (e) {
      String errorMessage = "An error occurred. Please try again.";

      if (e is AuthException) {
        errorMessage = e.message;
      }

      //* Show error toast message
      MotionToast.error(
        title: const Text("ERROR!"),
        description: Text(errorMessage),
        position: MotionToastPosition.top,
      ).show(Get.context!);
    }
  }

  //* Change email address
  Future<void> changeEmail(String email) async {
    try {
      final UserResponse res = await client.auth.updateUser(
        emailRedirectTo: authRedirectUri,
        UserAttributes(email: 'New Email'),
      );
      await client.from('users').insert({
        'email': email,
        'created_at': DateTime.now().toIso8601String(),
        'id': res.user!.id
      });

      //* Show loading dialog on successful reset
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitSpinningLines(
                  duration: Duration(milliseconds: 1000),
                  color: Colors.cyan,
                  size: 50.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  'LOADING...',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
      //* Delay execution for 3 seconds
      await Future.delayed(const Duration(seconds: 3));

      //* Close loading dialog on successful reset
      Get.back();

      //* Show success toast message
      MotionToast.success(
        title: const Text("SUCCESS!"),
        description: const Text("Check your email for confirmation"),
        position: MotionToastPosition.top,
      ).show(Get.context!);

      client.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;
        if (event == AuthChangeEvent.userUpdated && session != null) {
          Get.offAllNamed('/login');
        }
      });
    } catch (e) {
      String errorMessage = "An error occurred. Please try again.";

      if (e is AuthException) {
        errorMessage = e.message;
      }

      //* Show error toast message
      MotionToast.error(
        title: const Text("ERROR!"),
        description: Text(errorMessage),
        position: MotionToastPosition.top,
      ).show(Get.context!);
    }
  }

  //* Provider API login

  //* google [googleSignIn] login with google
  Future<void> googleSignIn() async {
    await client.auth.signInWithOAuth(
      Provider.google,
      redirectTo: kIsWeb ? null : authRedirectUri,
    );
    client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Get.offAllNamed('/home');
      } else {
        return;
      }
    });
  }

  // * twiiter [twitterSignIn] login with twitter
  Future<void> twitterSignIn() async {
    await client.auth.signInWithOAuth(
      Provider.twitter,
      redirectTo: kIsWeb ? null : authRedirectUri,
    );
    client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Get.offAllNamed('/home');
      } else {
        return;
      }
    });
  }

  // * facebook [facebookSignIn] login with facebook
  Future<void> facebookSignIn() async {
    await client.auth.signInWithOAuth(
      Provider.facebook,
      redirectTo: kIsWeb ? null : authRedirectUri,
    );
    client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Get.offAllNamed('/home');
      } else {
        return;
      }
    });
  }

  // * discord [discordSignIn] login with discord
  Future<void> discordSignIn() async {
    await client.auth.signInWithOAuth(
      Provider.discord,
      redirectTo: kIsWeb ? null : authRedirectUri,
    );
    client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Get.offAllNamed('/home');
      } else {
        return;
      }
    });
  }

  // * twitch [twitchSignIn] login with twitch
  Future<void> twitchSignIn() async {
    await client.auth.signInWithOAuth(
      Provider.twitch,
      redirectTo: kIsWeb ? null : authRedirectUri,
    );
    client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Get.offAllNamed('/home');
      } else {
        return;
      }
    });
  }
}
