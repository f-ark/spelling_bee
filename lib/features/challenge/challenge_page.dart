import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:spelling_bee/core/route/main_page_model.dart';
import 'package:spelling_bee/core/widgets/voice_mixin.dart';
import 'package:spelling_bee/core/widgets/voice_slider_control_widget.dart';

/// Öğrenilen ingilizce kelimeleri random olarak telaffuz eder,
/// bekleme süresinde kullanıcı tahmininin doğruluğunu sınar.
class ChallengePage extends ConsumerStatefulWidget {
  const ChallengePage({super.key});

  @override
  ConsumerState<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends ConsumerState<ChallengePage>
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            ref.read(mainPageModelProvider).changePage(MainPageType.home);
          },
        ),
        actions: const [VoiceSliderControlWidget()],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      _controller.isForwardOrCompleted ? '' : cachedWord,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(24),
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: nextEventButton,
                    child: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: _controller,
                      size: 64,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
