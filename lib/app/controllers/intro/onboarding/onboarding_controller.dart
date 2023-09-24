import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import '../../../constants/colors.dart';
import '../../../constants/animations_strings.dart';
import '../../../constants/text_strings.dart';
import '../../../models/model_onboarding.dart';
import '../../../widgets/pages/onboarding/onboarding_page.dart';

class OnBoardingController extends GetxController {
  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    OnBoardingPage(
      model: OnBoardingModel(
        animation: aOnboardingAnimation1,
        title: tOnBoardingTitle1,
        subTitle: tOnBoardingSubTitle1,
        counterText: tOnBoardingCounter1,
        bgColor: tOnBoardingPage1Color,
      ),
    ),
    OnBoardingPage(
      model: OnBoardingModel(
        animation: aOnboardingAnimation2,
        title: tOnBoardingTitle2,
        subTitle: tOnBoardingSubTitle2,
        counterText: tOnBoardingCounter2,
        bgColor: tOnBoardingPage2Color,
      ),
    ),
    OnBoardingPage(
      model: OnBoardingModel(
        animation: aOnboardingAnimation3,
        title: tOnBoardingTitle3,
        subTitle: tOnBoardingSubTitle3,
        counterText: tOnBoardingCounter3,
        bgColor: tOnBoardingPage3Color,
      ),
    ),
  ];

  skip() => controller.jumpToPage(page: 2);
  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    if (nextPage < pages.length) {
      controller.animateToPage(page: nextPage);
    } else {
      if (currentPage.value == 2) {
        Get.toNamed('/welcome');
      }
    }
  }

  onPageChangedCallback(int activePageIndex) =>
      currentPage.value = activePageIndex;
}
