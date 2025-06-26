import 'package:flutter/widgets.dart';

mixin WidgetHeightWatcher<T extends StatefulWidget> on State<T> {
  void waitForStableHeight({
    required GlobalKey key,
    required void Function(double height) onHeightReady,
  }) {
    double? lastHeight;
    bool heightCaptured = false;

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      if (heightCaptured) return;

      final context = key.currentContext;
      if (context == null) return;

      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) return;

      final currentHeight = renderBox.size.height;

      if (currentHeight > 0 && currentHeight != lastHeight) {
        lastHeight = currentHeight;
        WidgetsBinding.instance.scheduleFrame(); // Keep checking
      } else {
        heightCaptured = true;
        onHeightReady(currentHeight);
      }
    });
  }
}
