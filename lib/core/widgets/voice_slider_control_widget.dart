import 'package:flutter/material.dart';
import 'package:spelling_bee/core/widgets/voice_mixin.dart';

class VoiceSliderControlWidget extends StatefulWidget {
  const VoiceSliderControlWidget({super.key});

  @override
  State<VoiceSliderControlWidget> createState() =>
      _VoiceSliderControlWidgetState();
}

class _VoiceSliderControlWidgetState extends State<VoiceSliderControlWidget>
    with VoiceMixin {
  @override
  Widget build(BuildContext context) {
    return Slider(
      label: 'Hız',
      max: .9,
      min: .1,
      value: voiceSpeedValue,
      onChanged: (val) {
        volumeSpeed(val);
        setState(() {
          voiceSpeedValue = val;
        });
      },
    );
  }
}
