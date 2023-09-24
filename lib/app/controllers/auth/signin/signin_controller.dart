import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  RxBool isPasswordVisible = true.obs;

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }

  void resetForm() {
    emailC.clear();
    passwordC.clear();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }
}
