import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spelling_bee/core/services/shared_service.dart';
import 'package:spelling_bee/core/costants/word_list.dart';
import 'package:spelling_bee/core/widgets/voice_mixin.dart';
import 'package:spelling_bee/core/widgets/voice_slider_control_widget.dart';

/// Local cache desteği ile kelime listesi ve telafuzlarını barındıran sayfa
class LearningPage extends StatefulWidget {
  const LearningPage({super.key});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> with VoiceMixin {
  @override
  Widget build(BuildContext context) {
    const title = 'Öğren';
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),

        actions: const [VoiceSliderControlWidget()],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: WordList.words.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              key: ValueKey(index),
              onTap: () {
                // Kelimeye tıklandığında telaffuz et
                speak(WordList.words.keys.elementAt(index));
              },
              child: RedGreenChangerWidget(
                index: index,
                onPressed: () {
                  charSpell(WordList.words.keys.elementAt(index));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class RedGreenChangerWidget extends ConsumerStatefulWidget {
  const RedGreenChangerWidget({
    required this.index,
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;
  final int index;

  @override
  ConsumerState<RedGreenChangerWidget> createState() => _DragableWidgetState();
}

class _DragableWidgetState extends ConsumerState<RedGreenChangerWidget> {
  late final List<String> cacheItems;

  @override
  void initState() {
    cacheItems = ref.read(sharedPreferencesServiceProvider).getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: InkWell(
          onTap: () {
            if (cacheItems.contains(widget.index.toString())) {
              setState(() {
                cacheItems.remove(widget.index.toString());
              });
              ref
                  .read(sharedPreferencesServiceProvider)
                  .removeItem(widget.index.toString());
            } else {
              setState(() {
                cacheItems.add(widget.index.toString());
              });

              ref
                  .read(sharedPreferencesServiceProvider)
                  .addItem(widget.index.toString());
            }
          },
          child: CircleAvatar(
            backgroundColor:
                cacheItems.contains(widget.index.toString())
                    ? Colors.red
                    : Colors.green,
            child: Text(
              (widget.index + 1).toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        title: Text(
          WordList.words.keys.elementAt(widget.index),
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          WordList.words.values.elementAt(widget.index),
          style: const TextStyle(fontSize: 16),
        ),
        trailing: IconButton(
          onPressed: widget.onPressed,
          icon: const Icon(Icons.abc_outlined),
        ),
      ),
    );
  }
}
