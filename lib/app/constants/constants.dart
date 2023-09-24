import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const kOffBlack = Color(0xFF303030);
const kLeadBlack = Color(0xFF212121);
const kRaisinBlack = Color(0xFF222222);
const kGrey = Color(0xFF808080);
const kTinGrey = Color(0xFF909090);
const kGraniteGrey = Color(0xFF606060);
const kBasaltGrey = Color(0xFF999999);
const kTrolleyGrey = Color(0xFF828282);
const kNoghreiSilver = Color(0xFFBDBDBD);
const kChristmasSilver = Color(0xFFE0E0E0);
const kLynxWhite = Color(0xFFF7F7F7);
const kSnowFlakeWhite = Color(0xFFF0F0F0);
const kSeaGreen = Color(0xFF2AA952);
const kCrayolaGreen = Color(0xFF27AE60);
const kFireOpal = Color(0xFFEB5757);

const kYomogi10Grey = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 10,
  color: kGrey,
);
const kYomogi12Grey = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 12,
  color: kGrey,
);
const kYomogi12TrolleyGrey = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 12,
  color: kTrolleyGrey,
);
const kYomogiSemiBold12 = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: Color(0xCCFFFFFF),
);
const kYomogi14 = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 14,
  color: kOffBlack,
);
const kYomogi16 = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 14,
);
const kYomogiSemiBold16 = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: kOffBlack,
);
const kYomogiSemiBold16TinGrey = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: kTinGrey,
);
const kYomogiSemiBold16NorgheiSilver = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: kNoghreiSilver,
);
const kYomogiBold16 = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kOffBlack,
);
const kYomogi18 = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 18,
);
const kYomogiTinGrey18 = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 18,
  color: kTinGrey,
);
const kYomogiBold18 = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 18,
  color: kOffBlack,
  fontWeight: FontWeight.bold,
);
const kYomogiSemiBold18 = TextStyle(
  fontFamily: "Yomogi",
  fontSize: 18,
  color: kOffBlack,
  fontWeight: FontWeight.w600,
);
const kYomogiSemiBold20White = TextStyle(
    fontFamily: "Yomogi",
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white);
const kYomogiBold20 = TextStyle(
    fontFamily: "Yomogi",
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: kOffBlack);
const kYomogiBold24 = TextStyle(
    fontFamily: "Yomogi",
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: kOffBlack);
const kHinaMinchoBold16 = TextStyle(
  fontFamily: "HinaMincho",
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kOffBlack,
);
const kHinaMinchoBold24 = TextStyle(
    fontFamily: "HinaMincho",
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2);
const kHinaMincho30TinGrey = TextStyle(
  fontFamily: "HinaMincho",
  fontSize: 30,
  color: kTinGrey,
);
const kHinaMincho18 = TextStyle(
  fontFamily: "HinaMincho",
  fontSize: 18,
);
const inputDecorationConst = InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.always,
  labelStyle: TextStyle(
    fontFamily: "HinaMincho",
    color: kTinGrey,
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kChristmasSilver,
      width: 2,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kOffBlack,
      width: 2,
    ),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kFireOpal,
      width: 2,
    ),
  ),
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kFireOpal,
      width: 2,
    ),
  ),
);

Future<bool> kOnExitConfirmation() async {
  bool exit = false;
  await kDefaultDialog(
    "Exit",
    "Are you sure do you want to exit the app?",
    onYesPressed: () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      exit = true;
    },
  );
  return exit;
}

Future kDefaultDialog(String title, String message,
    {VoidCallback? onYesPressed}) async {
  if (GetPlatform.isIOS) {
    await Get.dialog(
      CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (onYesPressed != null)
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "Cancel",
              ),
            ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onYesPressed,
            child: Text(
              (onYesPressed == null) ? "Ok" : "Yes",
            ),
          ),
        ],
      ),
    );
  } else {
    await Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (onYesPressed != null)
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: kFireOpal,
                ),
              ),
            ),
          TextButton(
            onPressed: (onYesPressed == null)
                ? () {
                    Get.back();
                  }
                : onYesPressed,
            child: Text(
              (onYesPressed == null) ? "Ok" : "Yes",
              style: const TextStyle(
                color: kOffBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
