import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spelling_bee/core/app_start/app_start_provider.dart';
import 'package:spelling_bee/core/costants/costants.dart';
import 'package:spelling_bee/core/widgets/main_menu_elevated_button.dart';
import 'package:spelling_bee/features/challenge/challenge_page.dart';
import 'package:spelling_bee/features/learn/learning_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      home: MainPage(title: AppConstants.appName),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
    );
  }
}

class MainPage extends ConsumerWidget {
  MainPage({required this.title, super.key});

  final String title;
  final LinearGradient gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.blue.shade200, Colors.blue.shade900],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartup = ref.watch(appStartupProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade700,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: appStartup.when(
              data:
                  (data) => const Column(
                    children: [
                      MainMenuElevatedButon(
                        title: 'Tüm Liste',
                        color: Colors.blue,
                        page: OgrenPage(),
                        icon: Icons.list,
                      ),

                      SizedBox(height: 10),

                      MainMenuElevatedButon(
                        title: 'Yarış',
                        color: Colors.green,
                        page: ChallengePage(),
                        icon: Icons.access_time_rounded,
                      ),
                    ],
                  ),
              error: (error, stackTrace) => Text(error.toString()),
              loading: CircularProgressIndicator.new,
            ),
          ),
        ),
      ),
    );
  }
}
