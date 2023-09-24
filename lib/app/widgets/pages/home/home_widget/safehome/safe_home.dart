import 'package:background_sms/background_sms.dart';
/* import 'package:besafe/app/backend/supabase/database/db_services.dart';
import 'package:besafe/app/models/contactsm.dart'; */
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

// ignore: use_key_in_widget_constructors
class SafeHome extends StatefulWidget {
  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;

  // ignore: unused_element
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  // ignore: unused_element
  _sendSms(String phoneNumber, String message) async {
    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: 1);
    if (result == SmsStatus.sent) {
      // ignore: avoid_print
      print("Sent");
      Fluttertoast.showToast(msg: "send");
    } else {
      Fluttertoast.showToast(msg: "failed");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location services are disabled. Please enable the services')));
      }
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
        }
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')));
      }
      return false;
    }
    return true;
  }

  _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _curentPosition = position;
        // ignore: avoid_print
        print(_curentPosition!.latitude);
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _curentPosition!.latitude, _curentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
            "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
  }

  showModelSafeHome(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.4,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "SEND YOUR CUURENT LOCATION IMMEDIATELY TO YOU YOUR FRIEND",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  if (_curentPosition != null) Text(_curentAddress!),
                  PrimaryButton(
                      title: "GET LOCATION",
                      onPressed: () {
                        _getCurrentLocation();
                      }),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    title: "SHARE LOCATION",
                    onPressed: () async {
                      double latitude = _curentPosition?.latitude ?? 0;
                      double longitude = _curentPosition?.longitude ?? 0;
                      String address = _curentAddress ?? "";

                      String messageBody =
                          "I NEED YOUR HELP: https://www.google.com/maps/search/?api=1&query=$latitude%2C$longitude. $address";

                      try {
                        await Share.share(messageBody);
                        Fluttertoast.showToast(
                            msg: "Location shared successfully");
                      } catch (e) {
                        Fluttertoast.showToast(msg: "Failed to share location");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModelSafeHome(context),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: const BoxDecoration(),
          child: Row(
            children: [
              const Expanded(
                  child: Column(
                children: [
                  ListTile(
                    title: Text("Send Location"),
                    subtitle: Text("Share Location"),
                  ),
                ],
              )),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:
                    const Image(image: AssetImage('assets/images/route.jpg')),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
      height: 50,
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Text(
          title,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
