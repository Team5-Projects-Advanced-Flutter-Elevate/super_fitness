import 'package:flutter/material.dart';
import '../../../../core/colors/app_colors.dart';

class ExerciseLevelTab extends StatelessWidget {
  final String label;
  final String levelId;
  final int index;
  final num selectedTabIndex;
  final Function(String levelId, int index) onTap;

  const ExerciseLevelTab({
    super.key,
    required this.label,
    required this.levelId,
    required this.index,
    required this.selectedTabIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedTabIndex;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          onTap(levelId, index);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColorLight : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
