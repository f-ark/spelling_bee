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
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

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
        colorSchemeSeed: Colors.indigo,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
      ),
    );
  }
}

class MainPage extends ConsumerWidget {
  MainPage({required this.title, super.key});

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
