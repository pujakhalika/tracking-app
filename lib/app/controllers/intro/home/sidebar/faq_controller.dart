import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Faq {
  final String question;
  final String answer;
  final RxBool expanded;
  late AnimationController expandedController;

  Faq(this.question, this.answer)
      : expanded = false.obs,
        expandedController = AnimationController(
          vsync: Get.put(FaqController()),
          duration: const Duration(milliseconds: 300),
        );
}

class FaqController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var faqList = <Faq>[
    Faq(
      "What is the purpose of this tracking app?",
      "This tracking app is designed to help users monitor and manage various activities, items, or information seamlessly.",
    ),
    Faq(
      "How do I navigate to the FAQ section?",
      "To access the FAQ section, simply tap on the 'FAQ' option in the app's navigation menu.",
    ),
    // Add more faqs here
  ];
}
