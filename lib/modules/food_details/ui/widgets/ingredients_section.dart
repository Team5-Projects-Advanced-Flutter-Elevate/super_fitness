
import 'dart:ui';

import '../../../../core/bases/base_statless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/bases/base_inherited_widget.dart';
import '../../../../core/colors/app_colors.dart';
import '../view_model/food_details_cubit.dart';
class IngredientsSection extends BaseStatelessWidget {
  const IngredientsSection({super.key, required this.state});

  final FoodDetailsState state;

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              inherit.appLocalizations.ingredients,
              style: inherit.theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                  child: Container(
                    width: inherit.screenWidth,
                    color: AppColors.black.withAlpha(150),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder:
                          (context, index) => Row(
                        children: [
                          Text(
                            state.ingredients![index],
                            style: inherit.theme.textTheme.titleLarge
                                ?.copyWith(fontSize: 16),
                          ),
                          const Spacer(),
                          Text(
                            state.measures![index],
                            style: inherit.theme.textTheme.labelSmall
                                ?.copyWith(color: AppColors.mainColorDark),
                          ),
                        ],
                      ),
                      separatorBuilder:
                          (context, index) =>
                      const Divider(color: Color(0xFF2D2D2D)),
                      itemCount: state.ingredients!.length,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
