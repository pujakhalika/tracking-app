import 'package:besafe/app/widgets/helper/layout/bottombar/audio/audio_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        // Empty container, no need for the previous camera-related code
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final permissionStatus = await Permission.audio.request();

          if (permissionStatus.isGranted) {
            Get.to(() => const AudioView());
          } else {
            // Show permission denied message
            Get.snackbar(
              'Permission Denied',
              'Camera permission was not granted.',
              backgroundColor: Colors.red,
            );
          }
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}
