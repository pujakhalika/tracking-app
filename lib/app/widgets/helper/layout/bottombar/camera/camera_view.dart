import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photoAndVideo(
          initialCaptureMode: CaptureMode.photo,
          mirrorFrontCamera: true,
          photoPathBuilder: (sensors) async {
            final Directory extDir = await getTemporaryDirectory();
            final testDir = await Directory('${extDir.path}/Camera')
                .create(recursive: true);
            if (sensors.length == 1) {
              final String filePath =
                  '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
              return SingleCaptureRequest(filePath, sensors.first);
            } else {
              // Separate pictures taken with front and back camera
              return MultipleCaptureRequest(
                {
                  for (final sensor in sensors)
                    sensor:
                        '${testDir.path}/${sensor.position == SensorPosition.front ? 'front_' : "back_"}${DateTime.now().millisecondsSinceEpoch}.jpg',
                },
              );
            }
          },
          videoPathBuilder: (sensors) async {
            final Directory extDir = await getTemporaryDirectory();
            final testDir =
                await Directory('${extDir.path}/Video').create(recursive: true);
            if (sensors.length == 1) {
              final String filePath =
                  '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
              return SingleCaptureRequest(filePath, sensors.first);
            } else {
              return MultipleCaptureRequest({
                for (final sensor in sensors)
                  sensor:
                      '${testDir.path}/${sensor.position == SensorPosition.front ? 'front_' : "back_"}${DateTime.now().millisecondsSinceEpoch}.mp4',
              });
            }
          },
          videoOptions: VideoOptions(
            enableAudio: true,
            ios: CupertinoVideoOptions(
              fps: 10,
            ),
            android: AndroidVideoOptions(
              bitrate: 6000000,
              quality: VideoRecordingQuality.fhd,
              fallbackStrategy: QualityFallbackStrategy.lower,
            ),
          ),
          exifPreferences: ExifPreferences(saveGPSLocation: true),
        ),
        sensorConfig: SensorConfig.single(
          sensor: Sensor.position(SensorPosition.back),
          flashMode: FlashMode.auto,
          aspectRatio: CameraAspectRatios.ratio_4_3,
          zoom: 0.0,
        ),
        enablePhysicalButton: true,
        previewFit: CameraPreviewFit.fitWidth,
        onMediaTap: (mediaCapture) {
          OpenFilex.open(
            mediaCapture.captureRequest
                .when(single: (single) => single.file?.path),
          );
        },
        imageAnalysisConfig: AnalysisConfig(
          androidOptions: const AndroidAnalysisOptions.nv21(width: 250),
        ),
      ),
    );
  }
}
