import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  TextEditingController usernameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  RxBool isPasswordVisible = true.obs;
  final isValid = false.obs;

  @override
  void onClose() {
    usernameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }

  void resetForm() {
    usernameC.clear();
    emailC.clear();
    passwordC.clear();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }
}
