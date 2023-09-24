import 'package:besafe/app/backend/supabase/client/auth_client.dart';
import 'package:besafe/app/constants/animations_strings.dart';
import 'package:besafe/app/controllers/auth/forget/update_password_controller.dart';
/* import 'package:besafe/app/backend/supabase/client/auth_client.dart'; */
import 'package:besafe/app/backend/supabase/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constants/sizes.dart';

class UpdatePasswordScreen extends StatelessWidget {
  UpdatePasswordScreen({super.key});

  final UpdatePasswordController updatePasswordController =
      Get.put(UpdatePasswordController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        updatePasswordController.resetForm();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Password'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(sDefaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5.0),
                const Image(
                  image: AssetImage(aUpdatePassword),
                  height: sDefaultSize * 7,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Forget Password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Yomogi',
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.5),
                  child: TextFormField(
                    controller: updatePasswordController.emailC,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
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
                const SizedBox(height: 20),
                const Text(
                  'Enter your email address and we will send you a link to update your password.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'HinaMincho',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await AuthService(client).resetPassword(
                      updatePasswordController.emailC.text,
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
                    'Reset Password',
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
                    Get.back();
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
