import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';
import 'package:super_fitness/core/colors/app_colors.dart';

class CategoryItem extends BaseStatelessWidget {
  final String image;
  final String title;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  @override
  Widget customBuild(BuildContext context, inherit) {
    return InkWell(
      splashColor: AppColors.transparent,
      overlayColor: WidgetStateColor.transparent,
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(image, width: inherit.screenWidth * 0.17),
          const SizedBox(height: 4),
          Text(
            title,

            style: inherit.theme.textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
