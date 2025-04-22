import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spelling_bee/word_list.dart';
import 'package:spelling_bee/shared_service.dart';

import 'voice_mixin.dart';

class OgrenPage extends StatefulWidget {
  const OgrenPage({super.key});

  @override
  State<OgrenPage> createState() => _OgrenPageState();
}

class _OgrenPageState extends State<OgrenPage> with VoiceMixin {
  @override
  Widget build(BuildContext context) {
    String title = 'Öğren';
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,

        title: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo.shade700,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
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
  late final List<String> swipedItems;

  @override
  void initState() {
    swipedItems = ref.read(sharedPreferencesServiceProvider).getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: InkWell(
          onTap: () {

           if( swipedItems.contains(widget.index.toString()))
                {  setState(() {
                  swipedItems.remove(widget.index.toString());
                });
                  ref
                .read(sharedPreferencesServiceProvider)
                .removeItem(widget.index.toString());}
                else {
             setState(() {
               swipedItems.add(widget.index.toString());
             });

             ref
                 .read(sharedPreferencesServiceProvider)
                 .addItem(widget.index.toString());
           }
          },
          child: CircleAvatar(
            backgroundColor:
                swipedItems.contains(widget.index.toString())
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
          icon: const Icon(Icons.volume_up),
        ),
      ),
    );
  }
}
