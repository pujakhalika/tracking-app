import 'package:besafe/app/backend/supabase/client/auth_client.dart';
import 'package:besafe/app/constants/sizes.dart';
import 'package:besafe/app/constants/text_strings.dart';
import 'package:besafe/app/controllers/auth/signin/signin_controller.dart';
/* import 'package:besafe/app/backend/supabase/client/auth_client.dart'; */
import 'package:besafe/app/backend/supabase/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../constants/animations_strings.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final SigninController signinController = Get.put(SigninController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        signinController.resetForm();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(sDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: sDefaultSize),
                const Image(
                    image: AssetImage(aLoginAnimation1),
                    height: sDefaultSize * 7),
                const SizedBox(height: 1.0),
                const Text(
                  tLoginTitle,
                  style: TextStyle(
                    fontFamily: 'Yomogi',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 1.0),
                const Text(
                  tLoginSubTitle,
                  style: TextStyle(
                    fontFamily: 'HinaMincho',
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.5),
                  child: TextFormField(
                    controller: signinController.emailC,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(FontAwesomeIcons.user),
                      labelText: "Email",
                      labelStyle: const TextStyle(
                        fontFamily: 'HinaMincho',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.5),
                  child: Obx(() => TextFormField(
                        controller: signinController.passwordC,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: signinController.isPasswordVisible.value,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(5),
                            child: IconButton(
                              onPressed:
                                  signinController.togglePasswordVisibility,
                              icon: signinController.isPasswordVisible.value
                                  ? const Icon(FontAwesomeIcons.eyeSlash)
                                  : const Icon(FontAwesomeIcons.eye),
                            ),
                          ),
                          prefixIcon: const Icon(FontAwesomeIcons.key),
                          labelText: "Password",
                          labelStyle: const TextStyle(
                            fontFamily: 'HinaMincho',
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      )),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await AuthService(client).signIn(
                      signinController.emailC.text,
                      signinController.passwordC.text,
                    );
                    /* Get.offAllNamed('/verifyscreen'); */
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 1.5,
                      horizontal: 50,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontFamily: 'Yomogi',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
/*                 const SizedBox(height: 1.5),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/forgetpassword');
                  },
                  child: const Text(
                    tForgetPassword,
                    style: TextStyle(
                      fontFamily: 'Yomogi',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ), */
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontFamily: 'HinaMincho',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  tSocialLogin,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'HinaMincho',
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: sDefaultSize),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(
                      icon: FontAwesomeIcons.google,
                      color: Colors.red,
                      onPressed: () async {
                        await AuthService(client).googleSignIn();
                        /* Get.toNamed('/home'); */
                      },
                    ),
                    SocialButton(
                      icon: FontAwesomeIcons.xTwitter,
                      color: const Color(0xff1da1f2),
                      onPressed: () async {
                        await AuthService(client).twitterSignIn();
                        /* Get.toNamed('/home'); */
                      },
                    ),
                    SocialButton(
                      icon: FontAwesomeIcons.facebook,
                      color: const Color(0xff4267B2),
                      onPressed: () async {
                        await AuthService(client).facebookSignIn();
                        /* Get.toNamed('/home'); */
                      },
                    ),
                    SocialButton(
                      icon: Icons.discord,
                      color: const Color(0xff7289da),
                      onPressed: () async {
                        await AuthService(client).discordSignIn();
                        /*  Get.toNamed('/home'); */
                      },
                    ),
                    SocialButton(
                      icon: FontAwesomeIcons.twitch,
                      color: const Color(0xff9146ff),
                      onPressed: () async {
                        await AuthService(client).twitchSignIn();
                        /* Get.toNamed('/home'); */
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      tDontHaveAnAccount,
                      style: TextStyle(
                        fontFamily: 'HinaMincho',
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/signup');
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontFamily: 'Yomogi',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  tAppCopyright,
                  style: TextStyle(
                    fontFamily: 'OnePiece',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//--Custom Widget Social Button

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(10),
        shape: const CircleBorder(),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}
