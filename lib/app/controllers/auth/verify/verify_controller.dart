import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyController extends GetxController {
  TextEditingController emailC = TextEditingController();

  RxBool isPasswordVisible = true.obs;

  @override
  void onClose() {
    emailC.dispose();
    super.onClose();
  }

  void resetForm() {
    emailC.clear();
  }
}
