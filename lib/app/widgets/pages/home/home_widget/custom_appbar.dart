import 'package:besafe/app/utils/quotes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  // const CustomAppBar({super.key});
  Function? onTap;
  int? quoteIndex;
  // ignore: use_key_in_widget_constructors
  CustomAppBar({this.onTap, this.quoteIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: SizedBox(
        child: Text(
          sweetSayings[quoteIndex!],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}





