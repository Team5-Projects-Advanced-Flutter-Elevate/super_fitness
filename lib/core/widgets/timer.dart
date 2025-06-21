import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import '../colors/app_colors.dart';

class Timer extends StatelessWidget {
  const Timer({
    super.key,
    required ValueNotifier<bool> isLessThan5Minutes,
    required this.examDuration,
    required this.onTimeEnd,
  }) : _isLessThan5Minutes = isLessThan5Minutes;

  final ValueNotifier<bool> _isLessThan5Minutes;
  final int examDuration;
  final VoidCallback onTimeEnd;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        right: screenWidth * 0.03,
        left: screenWidth * 0.02,
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: _isLessThan5Minutes,
        builder: (context, isLessThan5Minutes, child) {
          return TimerCountdown(
            enableDescriptions: false,
            format: CountDownTimerFormat.minutesSeconds,
            timeTextStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: AppColors.mainColorDark,
            ),
            endTime: DateTime.now().add(
              Duration(minutes: 0, seconds: examDuration),
            ),
            onEnd: () {
              onTimeEnd();
            },
            onTick: (duration) {
              // Update the ValueNotifier without calling setState
              _isLessThan5Minutes.value = duration.inMinutes < 5;
            },
          );
        },
      ),
    );
  }
}
