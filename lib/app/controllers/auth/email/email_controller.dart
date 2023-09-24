import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailController extends GetxController {
  TextEditingController emailC = TextEditingController();

  @override
  void onClose() {
    emailC.dispose();
    super.onClose();
  }

  void resetForm() {
    emailC.clear();
  }
}
