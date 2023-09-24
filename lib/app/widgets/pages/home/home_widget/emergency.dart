import 'package:besafe/app/widgets/pages/home/home_widget/emergencies/ambulance_emergency.dart';
import 'package:besafe/app/widgets/pages/home/home_widget/emergencies/army_emergency.dart';
import 'package:besafe/app/widgets/pages/home/home_widget/emergencies/firebrigade_emeergency.dart';
import 'package:besafe/app/widgets/pages/home/home_widget/emergencies/police_emergency.dart';
import 'package:flutter/material.dart';

class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceEmergency(),
          AmbulanceEmergency(),
          FirebrigadeEmergency(),
          ArmyEmergency(),
        ],
      ),
    );
  }
}
