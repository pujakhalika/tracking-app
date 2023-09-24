import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:besafe/app/constants/sizes.dart';
import 'package:besafe/app/widgets/helper/animations/fade_animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:besafe/app/controllers/intro/splash/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashScreenController _splashScreenController =
      Get.put(SplashScreenController());

  SplashScreen({super.key});

  Widget buildImageContainer(String imagePath, double width) {
    return SafeArea(
      child: Container(
        width: width,
        height: 400,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
          ),
        ),
      ),
    );
  }

  Widget buildContentContainer(double width) {
    return Container(
      padding: const EdgeInsets.all(sDefaultSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FadeAnimation(
            1,
            Text(
              "BE SAFE",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'OnePiece',
                fontStyle: FontStyle.normal,
                height: 1.4,
                fontSize: 50,
              ),
            ),
          ),
          const SizedBox(height: 50),
          const FadeAnimation(
            1.3,
            Text(
              "Welcome to Be Safe App \nLet's put your personal safety first with Be Safe.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'HinaMincho',
                fontStyle: FontStyle.normal,
                height: 1.4,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 50),

          // Menambahkan inisialisasi controller
          GetBuilder<SplashScreenController>(
            init: _splashScreenController,
            builder: (controller) => FadeAnimation(
              1.6,
              AnimatedBuilder(
                animation: controller.scaleController,
                builder: (context, child) => Transform.scale(
                  scale: controller.scaleAnimation.value,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: controller.widthController,
                      builder: (context, child) => Container(
                        width: controller.widthAnimation.value,
                        height: 80,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xff452f2b).withOpacity(.2),
                        ),
                        child: InkWell(
                          onTap: () {
                            controller.scaleController.forward();
                          },
                          child: Stack(
                            children: [
                              AnimatedBuilder(
                                animation: controller.positionController,
                                builder: (context, child) => Positioned(
                                  left: controller.positionAnimation.value,
                                  child: AnimatedBuilder(
                                    animation: controller.scale2Controller,
                                    builder: (context, child) =>
                                        Transform.scale(
                                      scale: controller.scale2Animation.value,
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xff452f2b)
                                              .withOpacity(.2),
                                        ),

                                        // Memanggil Fungsi [controller] animasi icon
                                        child: controller.hideIcon == false
                                            ? const Icon(
                                                FontAwesomeIcons.arrowRight)
                                            : Container(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: -50,
            child: FadeAnimation(
              1,
              buildImageContainer('assets/images/one.png', width),
            ),
          ),
          Positioned(
            bottom: -100,
            child: FadeAnimation(
              1.3,
              buildImageContainer('assets/images/one.png', width),
            ),
          ),
          Positioned(
            bottom: -150,
            child: FadeAnimation(
              1.6,
              buildImageContainer('assets/images/one.png', width),
            ),
          ),
          Positioned(
            top: -50,
            child: FadeAnimation(
              1.8,
              buildImageContainer('assets/animations/gif/intro-2.gif', width),
            ),
          ),
          buildContentContainer(width),
        ],
      ),
    );
  }
}

/* /* import 'package:be_safe/app/controllers/splash_screen_controller.dart'; */
/* import 'package:get/get.dart'; */
/* import '../../../controllers/splash_screen_controller.dart'; */
//import 'package:simple_animations/simple_animations.dart';
//import 'package:skripsi_puja/app/consts/animations_strings.dart';
//import 'package:skripsi_puja/app/consts/image_strings.dart';
//import 'package:skripsi_puja/app/consts/sizes.dart';
//import 'package:skripsi_puja/app/consts/text_strings.dart';
//import 'package:skripsi_puja/app/controllers/splash_screen_controller.dart';
import 'package:be_safe/app/consts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:be_safe/app/view/pages/01_intro/fade_animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
/* import 'package:page_transition/page_transition.dart'; */
import '../02_onboarding/onboarding_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  bool hideIcon = false;

  late Animation<double> positionAnimation;
  late AnimationController positionController;
  late Animation<double> scale2Animation;
  late AnimationController scale2Controller;
  late Animation<double> scaleAnimation;
  late AnimationController scaleController;
  late Animation<double> widthAnimation;
  late AnimationController widthController;

  @override
  void dispose() {
    disposeAnimations();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializeAnimations();
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
      duration: const Duration(milliseconds: 400),
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
      duration: const Duration(milliseconds: 600),
    );

    positionAnimation = Tween<double>(
      begin: 0.0,
      end: 215.0,
    ).animate(positionController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            hideIcon = true;
          });
          scale2Controller.forward();
        }
      });

    scale2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    scale2Animation = Tween<double>(
      begin: 1.0,
      end: 32.0,
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
    Get.off(
      () => const OnBoardingScreen(), transition: Transition.fadeIn,
    );
  }

  Widget buildImageContainer(String imagePath, double width) {
    return Container(
      width: width,
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
        ),
      ),
    );
  }

  Widget buildContentContainer(double width) {
    return Container(
      padding: const EdgeInsets.all(sDefaultSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FadeAnimation(
            1,
            Text(
              "BE SAFE",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'OnePiece',
                fontStyle: FontStyle.normal,
                height: 1.4,
                fontSize: 50,
              ),
            ),
          ),

          const SizedBox(height: 50),
          const FadeAnimation(
            1.3,
            Text(
              "Welcome to Be Safe App \nLet's put your personal safety first with Be Safe.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'HinaMincho',
                fontStyle: FontStyle.normal,
                height: 1.4,
                fontSize: 20,
              ),
            ),
          ),

          const SizedBox(height: 50),
          FadeAnimation(
            1.6,
            AnimatedBuilder(
              animation: scaleController,
              builder: (context, child) => Transform.scale(
                scale: scaleAnimation.value,
                child: Center(
                  child: AnimatedBuilder(
                    animation: widthController,
                    builder: (context, child) => Container(
                      width: widthAnimation.value,
                      height: 80,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xff452f2b).withOpacity(.4),
                      ),
                      child: InkWell(
                        onTap: () {
                          scaleController.forward();
                        },
                        child: Stack(
                          children: [
                            AnimatedBuilder(
                              animation: positionController,
                              builder: (context, child) => Positioned(
                                left: positionAnimation.value,
                                child: AnimatedBuilder(
                                  animation: scale2Controller,
                                  builder: (context, child) => Transform.scale(
                                    scale: scale2Animation.value,
                                    child:Container(
                                      width: 70,
                                      height: 70,
                                      decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:const Color(0xff797979).withOpacity(.4),
                                        backgroundBlendMode: BlendMode.colorDodge,
                                      ),

                                     ///--- Memanggil Fungsi Child Animation ke Container dan menavigate ke OnBoarding Screen ---
                                      child: hideIcon == false
                                          ? const Icon(FontAwesomeIcons.arrowRight)
                                          : Container(),

                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: -50,
            child: FadeAnimation(
              1,
              buildImageContainer('assets/images/one.png', width),
            ),
          ),

          Positioned(
            bottom: -100,
            child: FadeAnimation(
              1.3,
              buildImageContainer('assets/images/one.png', width),
            ),
          ),

          Positioned(
            bottom: -150,
            child: FadeAnimation(
              1.6,
              buildImageContainer('assets/images/one.png', width),
            ),
          ),

          Positioned(
            top: -30,
            child: FadeAnimation(
              1.8,
              buildImageContainer('assets/animations/gif/intro-2.gif', width),
            ),
          ),

/*           Positioned(
            top: -120,
            bottom: 80,
            child: FadeAnimation(
              1.8,
              buildImageContainer('assets/animations/gif/marker-1.gif', width),
            ),
          ), */

          buildContentContainer(width),
        ],
      ),
    );
  }
}









 */
