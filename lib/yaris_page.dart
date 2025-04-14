import 'package:flutter/material.dart';

import 'mixin.dart';

class YarisPage extends StatefulWidget {
  const YarisPage({super.key});

  @override
  State<YarisPage> createState() => _YarisPageState();
}

class _YarisPageState extends State<YarisPage>
    with Ses, SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String kelime = '';

  Future<void> esitle() async {
    kelime = await restgeleKelime();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yarış Sayfası'),
        // actions: [
        //   Slider(
        //     label: 'Hız',
        //     max: .9,
        //     min: .1,
        //     value: value,
        //     onChanged: (val) {
        //       volumeSpeed(val);
        //       setState(() {
        //         value = val;
        //       });
        //     },
        //   ),
        // ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                _controller.isForwardOrCompleted? '':kelime,
              style: Theme.of(context).textTheme.headlineLarge
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {});
                if (_controller.isCompleted) {
                  _controller.reverse();

                } else {
                  esitle();
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
