import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:besafe/app/constants/sizes.dart';
import "package:flutter/material.dart";

import '../../../models/model_onboarding.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(sDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(model.animation),
            height: size.height * 0.45,
          ),
          Column(
            children: [
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    model.title,
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
              Text(
                model.subTitle,
                style: const TextStyle(
                    fontFamily: 'HinaMincho',
                    fontStyle: FontStyle.normal,
                    height: 1.4,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text(
            model.counterText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 80.0,
          )
        ],
      ),
    );
  }
}
