


import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AutoDisposeCache on AutoDisposeRef {

  void cacheFor(Duration duration) {
    ///The keepAlive method will tell the provider to keep its state indefinitely,
    /// causing it to update only if we refresh or invalidate it.
    final link = keepAlive();
    // start timer with param duration
    final timer = Timer(duration, () => link.close());
    /// make sure to cancel the timer when the provider state is disposed
    onDispose(() => timer.cancel());
  }
  
}
extension AutoDisposeNotifierCache on AutoDisposeNotifierProviderRef {

  void notifierCacheFor(Duration duration) {
    ///The keepAlive method will tell the provider to keep its state indefinitely,
    /// causing it to update only if we refresh or invalidate it.
    final link = keepAlive();
    // start timer with param duration
    final timer = Timer(duration, () => link.close());
    /// make sure to cancel the timer when the provider state is disposed
    onDispose(() => timer.cancel());
  }
  
}