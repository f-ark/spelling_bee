import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:spelling_bee/core/app_start/app_start_provider.dart';
import 'package:spelling_bee/core/costants/costants.dart';
import 'package:spelling_bee/core/route/app_route_information_parser.dart';
import 'package:spelling_bee/core/route/app_router_delegate.dart';
import 'package:spelling_bee/core/route/main_page_model.dart';
import 'package:spelling_bee/core/widgets/main_menu_elevated_button.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouterDelegate = AppRouterDelegate(ref: ref);
    final appRouteInformationParser = AppRouteInformationParser();

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouterDelegate,
      routeInformationParser: appRouteInformationParser,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
          secondary: Colors.tealAccent,
          background: Colors.grey.shade50,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shadowColor: Colors.deepPurple.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
          ),
        ),
      ),
    );
  }
}

class MainPage extends ConsumerWidget {
  const MainPage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartup = ref.watch(appStartupProvider);

    return Scaffold(
      appBar: AppBar(title: Text(title)),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: appStartup.when(
            data:
                (data) => Column(
                  children: [
                    MainMenuElevatedButon(
                      title: 'Tüm Liste',
                      color: Colors.blue,
                      onPressed:
                          () => ref
                              .read(mainPageModelProvider)
                              .changePage(MainPageType.learn),
                      icon: Icons.list,
                    ),
                    const SizedBox(height: 10),
                    MainMenuElevatedButon(
                      onPressed:
                          () => ref
                              .read(mainPageModelProvider)
                              .changePage(MainPageType.challenge),
                      title: 'Yarış',
                      color: Colors.green,
                      icon: Icons.access_time_rounded,
                    ),
                  ],
                ),
            error: (error, stackTrace) => Text(error.toString()),
            loading: CircularProgressIndicator.new,
          ),
        ),
      ),
    );
  }
}
