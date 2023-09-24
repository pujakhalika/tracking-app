import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const SecondaryButton(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
          onPressed: () {
            onPressed();
          },
          child: Text(
            title,
            style: const TextStyle(fontSize: 18),
          )),
    );
  }
}
