import 'package:flutter/material.dart';

import 'package:spelling_bee/core/widgets/voice_mixin.dart';
import 'package:spelling_bee/core/widgets/voice_slider_control_widget.dart';

/// Öğrenilen ingilizce kelimeleri random olarak telaffuz eder,
/// bekleme süresinde kullanıcı tahmininin doğruluğunu sınar.
class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage>
    with VoiceMixin, SingleTickerProviderStateMixin {
  late AnimationController _controller;

  String cachedWord = '';

  Future<void> randomWordGenerate() async {
    cachedWord = await randomWord();
  }

  void nextEventButton() {
    setState(() {});
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      randomWordGenerate();
      _controller.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Yarışma';
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),

        actions: const [VoiceSliderControlWidget()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              _controller.isForwardOrCompleted ? '' : cachedWord,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                shadows: [
                  const Shadow(
                    blurRadius: 16,
                    color: Colors.black26,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: nextEventButton,
              child: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: _controller,
                size: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
