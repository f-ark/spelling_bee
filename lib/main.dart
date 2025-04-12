import 'package:flutter/material.dart';
import 'package:spelling_bee/yaris_page.dart';

import 'ogren_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const title = 'Spelling Bee';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: title, home: AnaSayfa(title: title),
    debugShowCheckedModeBanner: false,
    theme: ThemeData( colorSchemeSeed: Colors.indigoAccent,)


    );
  }
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Expanded(
                child: ElevatedButton(

                  style: ButtonStyle(

                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OgrenPage()),
                    );
                  },

                  child: Text(
                    'Öğren',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              Spacer(),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.amber),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => YarisPage()),
                    );
                  },
                  child: Text(
                    'Yarış',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
