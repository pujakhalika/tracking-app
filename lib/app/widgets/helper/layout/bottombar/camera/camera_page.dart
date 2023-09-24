import 'package:besafe/app/widgets/helper/layout/bottombar/camera/camera_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        // Empty container, no need for the previous camera-related code
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final permissionStatus = await Permission.camera.request();

          if (permissionStatus.isGranted) {
            Get.to(() => const CameraView());
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
