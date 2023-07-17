import 'package:flutter/foundation.dart';

import '../../app.dart';

extension DebugBorderWidgetExtension on Widget {
  Widget debugBorder() {
    if (kDebugMode) {
      return DecoratedBox(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.red, width: 4)),
        child: this,
      );
    } else {
      return this;
    }
  }
}
