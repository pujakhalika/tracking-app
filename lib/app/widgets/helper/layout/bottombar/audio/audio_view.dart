// ignore: depend_on_referenced_packages
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class AudioView extends StatelessWidget {
  const AudioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AudioWaveforms(
                size: Size(MediaQuery.of(context).size.width, 200.0),
                recorderController: RecorderController(),
                enableGesture: true,
                waveStyle: const WaveStyle(
                  waveColor: Colors.cyan,
                  showDurationLabel: true,
                  spacing: 8.0,
                  extendWaveform: true,
                  showMiddleLine: true,
                )),
            AudioFileWaveforms(
              size: Size(MediaQuery.of(context).size.width, 200.0),
              playerController: PlayerController(),
              enableSeekGesture: true,
              waveformType: WaveformType.long,
              waveformData: const [],
              playerWaveStyle: const PlayerWaveStyle(),
            )
          ],
        ),
      ),
    );
  }
}
