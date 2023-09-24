import 'package:besafe/app/backend/supabase/client/auth_client.dart';
import 'package:besafe/app/constants/animations_strings.dart';
import 'package:besafe/app/controllers/auth/email/email_controller.dart';
import 'package:besafe/app/backend/supabase/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constants/sizes.dart';

class ChangeEmailScreen extends StatelessWidget {
  ChangeEmailScreen({super.key});

  final EmailController changeEmailController = Get.put(EmailController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        changeEmailController.resetForm();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Email Change'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(sDefaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5.0),
                const Image(
                  image: AssetImage(aEmailChange),
                  height: sDefaultSize * 7,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Change Email',
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
                    controller: changeEmailController.emailC,
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
                  'Enter your email address and we will send you a link to reset your password.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'HinaMincho',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await AuthService(client).changeEmail(
                      changeEmailController.emailC.text,
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
                    'Change Email',
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
