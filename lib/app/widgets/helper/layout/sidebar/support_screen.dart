import 'package:flutter/material.dart';
import 'package:flutter_donation_buttons/donationButtons/ko-fiButton.dart';
import 'package:get/get.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            KofiButton(
              onDonation: () => printInfo(
                info: 'On Donation!',
              ),
              kofiName: 'pujakhalika',
              kofiColor: KofiColor.Red,
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    fontSize: 20,
                    fontFamily: 'HinaMincho',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
