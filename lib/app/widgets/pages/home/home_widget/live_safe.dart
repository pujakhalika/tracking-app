import 'dart:io';

import 'package:besafe/app/widgets/pages/home/home_widget/live_safe/bus_station_card.dart';
import 'package:besafe/app/widgets/pages/home/home_widget/live_safe/hospital_card.dart';
import 'package:besafe/app/widgets/pages/home/home_widget/live_safe/pharmacy_card.dart';
import 'package:besafe/app/widgets/pages/home/home_widget/live_safe/police_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class LiveSafe extends StatelessWidget {
  const LiveSafe({Key? key}) : super(key: key);

  static Future<void> openMap(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/$location';

    if (Platform.isAndroid) {
      if (await canLaunchUrl(Uri.parse(googleUrl))) {
        await launchUrl(Uri.parse(googleUrl));
      } else {
        throw 'Could not launch $googleUrl';
      }
    }
    // final Uri _url = Uri.parse(googleUrl);
    // try {
    //   await launchUrl(_url);
    // } catch (e) {
    //   Fluttertoast.showToast(
    //       msg: 'something went wrong! call emergency number');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: const [
          PoliceStationCard(onMapFunction: openMap),
          HospitalCard(onMapFunction: openMap),
          PharmacyCard(onMapFunction: openMap),
          BusStationCard(onMapFunction: openMap),
        ],
      ),
    );
  }
}
