import 'dart:async';

import 'package:tago/app.dart';

extension AutoDisposeRefCache on AutoDisposeRef {
  // keeps the provider alive for [duration] since when it was first created
  // (even if all the listeners are removed before then)
  void cacheFor(Duration duration) {
    final link = keepAlive();
    final timer = Timer(duration, () => link.close());
    onDispose(() => timer.cancel());
  }
}
