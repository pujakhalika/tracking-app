import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRecoveryController extends GetxController {
  TextEditingController passwordC = TextEditingController();

  RxBool isPasswordVisible = true.obs;

  @override
  void onClose() {
    passwordC.dispose();
    super.onClose();
  }

  void resetForm() {
    passwordC.clear();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }
}
