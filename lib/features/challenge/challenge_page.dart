import 'package:flutter/material.dart';

import 'package:spelling_bee/core/widgets/voice_mixin.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage>
    with VoiceMixin, SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _textController;

  String kelime = '';

  Future<void> rastgeleKelimeUret() async {
    kelime = await randomWord();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const  title = 'Yarışma';
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.indigo.shade700,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          Slider(
            label: 'Hız',
            max: .9,
            min: .1,
            value: value,
            onChanged: (val) {
              volumeSpeed(val);
              setState(() {
                value = val;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              _controller.isForwardOrCompleted ? '' : kelime,
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
              onPressed: () {
                setState(() {});
                if (_controller.isCompleted) {
                  _controller.reverse();
                } else {
                  rastgeleKelimeUret();
                  _controller.forward();
                }
              },
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
