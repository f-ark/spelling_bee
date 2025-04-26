import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spelling_bee/core/costants/costants.dart';
import 'package:spelling_bee/core/route/main_page_model.dart';
import 'package:spelling_bee/features/challenge/challenge_page.dart';
import 'package:spelling_bee/features/learn/learning_page.dart';
import 'package:spelling_bee/main.dart';

class AppRouterDelegate extends RouterDelegate<MainPageType>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MainPageType> {
  AppRouterDelegate({required this.ref});

  final WidgetRef ref;
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  MainPageType get currentConfiguration =>
      ref.watch(mainPageModelProvider).page;

  @override
  Widget build(BuildContext context) {
    final pages = <MaterialPage<void>>[

      switch (currentConfiguration) {
        MainPageType.challenge => const MaterialPage(
          key: ValueKey('challenge'),
          child: ChallengePage(),
          fullscreenDialog: true,
        ),
        MainPageType.learn => const MaterialPage(
          key: ValueKey('learning'),
          child: LearningPage(),
        ),
        _ =>  MaterialPage(
          key: const ValueKey('home'),
          child: MainPage(title: AppConstants.appName),
        ),
      },
    ];

    return Navigator(
      key: navigatorKey,
      pages: pages,

      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MainPageType configuration) async {
    ref.read(mainPageModelProvider.notifier).changePage(configuration);
  }
}
