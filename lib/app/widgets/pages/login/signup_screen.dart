import 'package:besafe/app/backend/supabase/client/auth_client.dart';
import 'package:besafe/app/constants/animations_strings.dart';
import 'package:besafe/app/constants/sizes.dart';
import 'package:besafe/app/constants/text_strings.dart';
import 'package:besafe/app/controllers/auth/signup/signup_controller.dart';
/* import 'package:besafe/app/backend/supabase/client/auth_client.dart'; */
import 'package:besafe/app/backend/supabase/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        signupController.resetForm();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(sDefaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5.0),
                const Image(
                  image: AssetImage(aSignUp),
                  height: sDefaultSize * 7,
                ),
                const SizedBox(height: 10.0),
                const Text(
                  tSignupSubTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Yomogi',
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.5),
                  child: TextFormField(
                    controller: signupController.usernameC,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(FontAwesomeIcons.user),
                      labelText: "Name",
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
                  child: TextFormField(
                    controller: signupController.emailC,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
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
                        controller: signupController.passwordC,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        obscureText: signupController.isPasswordVisible.value,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(5),
                            child: IconButton(
                              onPressed:
                                  signupController.togglePasswordVisibility,
                              icon: signupController.isPasswordVisible.value
                                  ? const Icon(FontAwesomeIcons.eyeSlash)
                                  : const Icon(FontAwesomeIcons.eye),
                            ),
                          ),
                          prefixIcon: const Icon(FontAwesomeIcons.lock),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await AuthService(client).signUp(
                        signupController.usernameC.text,
                        signupController.emailC.text,
                        signupController.passwordC.text);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Yomogi',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Yomogi',
                    ),
                  ),
                  child: const Text('Go Back'),
                ),
                const SizedBox(height: 1.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      tAlreadyHaveAccount,
                      style: TextStyle(
                        fontFamily: 'HinaMincho',
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontFamily: 'Yomogi',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1.0),
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
