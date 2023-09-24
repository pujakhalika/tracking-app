import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:besafe/app/constants/animations_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/sizes.dart';
import 'package:besafe/app/constants/text_strings.dart';
/* import '../04_login/login_screen.dart'; */

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(sDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(wWelcomeMain),
            const SizedBox(height: 1.0),
            Column(
              children: [
                AnimatedTextKit(
                  totalRepeatCount: 3,
                  animatedTexts: [
                    TyperAnimatedText(
                      tAppName1,
                      speed: const Duration(milliseconds: 300),
                      textStyle: const TextStyle(
                        fontFamily: 'Yomogi',
                        fontStyle: FontStyle.normal,
                        height: 1.4,
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      tAppTagline,
                      speed: const Duration(milliseconds: 80),
                      textStyle: const TextStyle(
                        fontFamily: 'Yomogi',
                        fontStyle: FontStyle.normal,
                        height: 1.4,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const Text(
                  tAppTagline1,
                  style: TextStyle(
                    fontFamily: 'HinaMincho',
                    fontStyle: FontStyle.normal,
                    height: 1.5,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  tAppTagline2,
                  style: TextStyle(
                    fontFamily: 'HinaMincho',
                    fontStyle: FontStyle.normal,
                    height: 1.5,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/login');
                    },
                    style: ButtonStyle(
                      fixedSize:
                          const MaterialStatePropertyAll(Size.fromHeight(50)),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.play_arrow),
                        const SizedBox(width: 10),
                        AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            WavyAnimatedText(
                              tWelcomeButton,
                              textStyle: const TextStyle(
                                fontFamily: 'Yomogi',
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
