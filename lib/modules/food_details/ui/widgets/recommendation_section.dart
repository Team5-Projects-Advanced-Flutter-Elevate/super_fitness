import '../../../../core/bases/base_statless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/bases/base_inherited_widget.dart';
import '../../../../core/colors/app_colors.dart';
class RecommendationSection extends BaseStatelessWidget {
  const RecommendationSection({super.key});

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              inherit.appLocalizations.recommendation,
              style: inherit.theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder:
                    (context, index) => Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(16),
                  width: inherit.screenWidth * 0.44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.mainColorDark,
                  ),
                  child: Text(
                    'data',
                    style: inherit.theme.textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
