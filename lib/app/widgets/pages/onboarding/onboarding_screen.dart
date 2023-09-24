import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../controllers/intro/onboarding/onboarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final obController = OnBoardingController();
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: obController.pages,
            enableSideReveal: true,
            liquidController: obController.controller,
            onPageChangeCallback: obController.onPageChangedCallback,
            slideIconWidget: const Icon(FontAwesomeIcons.chevronLeft, size: 30),
            waveType: WaveType.circularReveal,
          ),
          Positioned(
            bottom: 60,
            child: ElevatedButton(
              onPressed: () => obController.animateToNextSlide(),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: const Icon(
                  FontAwesomeIcons.arrowRight,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: ElevatedButton(
              onPressed: () => obController.skip(),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  WavyAnimatedText(
                    'Skip',
                    textStyle: const TextStyle(
                      fontFamily: 'Yomogi',
                      fontStyle: FontStyle.normal,
                      height: 1.4,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 20,
              child: AnimatedSmoothIndicator(
                  count: 3,
                  activeIndex: obController.currentPage.value,
                  effect: const WormEffect(
                    type: WormType.thin,
                    activeDotColor: Color(0xff452f2b),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
