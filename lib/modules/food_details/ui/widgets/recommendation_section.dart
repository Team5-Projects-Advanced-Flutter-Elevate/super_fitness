import 'package:super_fitness/modules/food_details/ui/view_model/food_details_cubit.dart';

import '../../../../core/bases/base_statless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/bases/base_inherited_widget.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/widgets/custom_item_container.dart';

class RecommendationSection extends BaseStatelessWidget {
  const RecommendationSection({super.key, required this.state});

  final FoodDetailsState state;

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
                    (context, index) => CustomItemContainer(
                      imageUrl:
                          state.foodDetailsEntity?.mealEntity?.strMealThumb ??
                          '',
                      width: inherit.screenWidth * 0.45,
                      title: "Food".replaceFirst(" ", "\n"),
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
