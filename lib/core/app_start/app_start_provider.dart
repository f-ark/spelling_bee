import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spelling_bee/core/app_start/shared_service.dart';

/// Bağımlılıkları uygulama açılışında başlatan provider
final AutoDisposeFutureProvider<void> appStartupProvider =
    FutureProvider.autoDispose<void>((ref) async {
      ref.keepAlive();
      await ref.watch(sharedPreferencesWithCacheProvider.future);
    });
