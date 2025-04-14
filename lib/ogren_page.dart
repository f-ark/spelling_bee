import 'package:flutter/material.dart';
import 'package:spelling_bee/kelime_listesi.dart';

import 'mixin.dart';

class OgrenPage extends StatefulWidget {
  const OgrenPage({super.key});

  @override
  State<OgrenPage> createState() => _OgrenPageState();
}

class _OgrenPageState extends State<OgrenPage> with Ses{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğren'),
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
        child: ListView.builder(
          itemCount: WordList.words.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                // Kelimeye tıklandığında telaffuz et
                speak(WordList.words.keys.elementAt(index));
              },
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      (index + 1).toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    WordList.words.keys.elementAt(index),
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    WordList.words.values.elementAt(index),
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      harfHecele(WordList.words.keys.elementAt(index));
                    },
                    icon: const Icon(Icons.volume_up),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
