import 'package:besafe/app/backend/supabase/client/auth_client.dart';
import 'package:besafe/app/constants/animations_strings.dart';
/* import 'package:besafe/app/backend/supabase/client/auth_client.dart'; */
import 'package:besafe/app/backend/supabase/services/auth_service.dart';
import 'package:besafe/app/controllers/auth/recovery/password_recovery_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../../constants/sizes.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  PasswordRecoveryScreen({super.key});

  final PasswordRecoveryController passwordRecoveryController =
      Get.put(PasswordRecoveryController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        passwordRecoveryController.resetForm();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Password Recovery'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(sDefaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5.0),
                const Image(
                  image: AssetImage(aRecoverPassword),
                  height: sDefaultSize * 7,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Password Recovery',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Yomogi',
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.5),
                  child: Obx(() => TextFormField(
                        controller: passwordRecoveryController.passwordC,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText:
                            passwordRecoveryController.isPasswordVisible.value,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(5),
                            child: IconButton(
                              onPressed: passwordRecoveryController
                                  .togglePasswordVisibility,
                              icon: passwordRecoveryController
                                      .isPasswordVisible.value
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
                const SizedBox(height: 20),
                const Text(
                  'Enter your new password here.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'HinaMincho',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await AuthService(client).recoverPassword(
                      passwordRecoveryController.passwordC.text,
                    );
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
                    'New Password',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Yomogi',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.offAndToNamed('/login');
                  },
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Yomogi',
                    ),
                  ),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
