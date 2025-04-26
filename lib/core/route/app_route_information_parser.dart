import 'package:flutter/material.dart';
import 'package:spelling_bee/core/route/main_page_model.dart';

class AppRouteInformationParser extends RouteInformationParser<MainPageType> {
  @override
  Future<MainPageType> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = routeInformation.uri;


   return switch (uri.pathSegments.isEmpty ? 'home'
       : uri.pathSegments.first) {

       'challenge'=>
         MainPageType.challenge,
       'learn'=>
         MainPageType.learn,
      _ => MainPageType.home,
    };
  }

  @override
  RouteInformation? restoreRouteInformation(MainPageType configuration) {
    return switch (configuration) {
      MainPageType.challenge => RouteInformation(uri: Uri(path: "/challenge")),
      MainPageType.learn => RouteInformation(uri: Uri(path: "/learn")),
      _ => RouteInformation(uri: Uri(path: "/")),

    };
  }
}
