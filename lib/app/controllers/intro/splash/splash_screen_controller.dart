import 'package:flutter/material.dart';
import 'package:get/get.dart';

/* import '../view/pages/02_onboarding/onboarding_screen.dart'; */

class SplashScreenController extends GetxController
    with GetTickerProviderStateMixin {
  late Animation<double> positionAnimation;
  late AnimationController positionController;
  late Animation<double> scale2Animation;
  late AnimationController scale2Controller;
  late Animation<double> scaleAnimation;
  late AnimationController scaleController;
  late Animation<double> widthAnimation;
  late AnimationController widthController;

  bool hideIcon = false;

  @override
  void onInit() {
    super.onInit();
    initializeAnimations();
  }

  @override
  void onClose() {
    disposeAnimations();
    super.onClose();
  }

  void initializeAnimations() {
    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widthController.forward();
        }
      });

    widthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    widthAnimation = Tween<double>(
      begin: 80.0,
      end: 300.0,
    ).animate(widthController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          positionController.forward();
        }
      });

    positionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    positionAnimation = Tween<double>(
      begin: 0.0,
      end: 200.0,
    ).animate(positionController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          hideIcon = true;
          scale2Controller.forward();
        }
      });

    scale2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    scale2Animation = Tween<double>(
      begin: 1.0,
      end: 100.0,
    ).animate(scale2Controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          navigateToOnBoardingScreen();
        }
      });
  }

  void disposeAnimations() {
    scaleController.dispose();
    widthController.dispose();
    positionController.dispose();
    scale2Controller.dispose();
  }

  void navigateToOnBoardingScreen() {
    Get.offNamed('/onboarding');
  }
}
