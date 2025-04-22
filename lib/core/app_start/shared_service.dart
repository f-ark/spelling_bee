import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCacheService {

  SharedPreferencesCacheService({required this.key, required this.prefs});
  final String key;
  final SharedPreferencesWithCache prefs;

  Future<void> saveList(List<String> items) async {
    await prefs.setStringList(key, items);
  }

  List<String> getList() {
    return prefs.getStringList(key) ?? [];
  }

  Future<void> addItem(String item) async {
    final currentList = getList()
    ..add(item);
    await saveList(currentList);
  }

  Future<void> removeItem(String item) async {
    final currentList = getList()
    ..remove(item);
    await saveList(currentList);
  }
}

final FutureProvider<SharedPreferencesWithCache>
sharedPreferencesWithCacheProvider = FutureProvider<SharedPreferencesWithCache>(
  (ref) async {
    return SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{'words'},
      ),
    );
  },
);

final sharedPreferencesServiceProvider =
    Provider<SharedPreferencesCacheService>((ref) {
      final sharedPreferences =
          ref.watch(sharedPreferencesWithCacheProvider).requireValue;
      return SharedPreferencesCacheService(
        key: 'words',
        prefs: sharedPreferences,
      );
    });
