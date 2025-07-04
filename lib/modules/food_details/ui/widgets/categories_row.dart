import '../../../../core/bases/base_statless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/bases/base_inherited_widget.dart';
import '../../../../core/colors/app_colors.dart';

class CaloriesRow extends BaseStatelessWidget {
  const CaloriesRow({super.key});

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          4,
          (index) => Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.white),
              borderRadius: BorderRadius.circular(22),
            ),

            child: Column(
              children: [
                Text(
                  inherit.appLocalizations.energyValue,
                  style: inherit.theme.textTheme.labelSmall,
                ),
                Text(
                  inherit.appLocalizations.energy,
                  style: inherit.theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.mainColorDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
