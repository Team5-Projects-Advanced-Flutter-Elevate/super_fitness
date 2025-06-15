import 'package:flutter/material.dart';

class LoadingStateWidget extends StatelessWidget {
  final Color? progressIndicatorColor;

  const LoadingStateWidget({super.key, this.progressIndicatorColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: progressIndicatorColor),
    );
  }
}
