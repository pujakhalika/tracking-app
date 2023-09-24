import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  bool loading;
  // ignore: use_key_in_widget_constructors
  PrimaryButton(
      {required this.title, required this.onPressed, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
