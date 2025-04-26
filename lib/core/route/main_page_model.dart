import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MainPageType { home,learn, challenge }

final ChangeNotifierProvider<MainPageModel> mainPageModelProvider =
ChangeNotifierProvider<MainPageModel>((ref) {
  return MainPageModel(MainPageType.home);
});

class MainPageModel extends ChangeNotifier {
  MainPageType _page;

  MainPageModel(this._page);

  MainPageType get page => _page;

  void changePage(MainPageType page) {
    _page = page;
    notifyListeners();
  }
}