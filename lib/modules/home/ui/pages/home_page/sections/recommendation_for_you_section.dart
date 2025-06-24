import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/widgets/custom_recommendation_container.dart';

class RecommendationForYouSection extends StatefulWidget {
  const RecommendationForYouSection({super.key});

  @override
  State<RecommendationForYouSection> createState() =>
      _RecommendationForYouSectionState();
}

class _RecommendationForYouSectionState
    extends BaseStatefulWidgetState<RecommendationForYouSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Recommendation For You",
              textAlign: TextAlign.start,
              style: theme.textTheme.titleMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                "See All",
                style: theme.textTheme.titleSmall!.copyWith(
                  color: AppColors.mainColorLight,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 104,
          width: screenWidth,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const CustomRecommendationContainer(
                imageUrl: "https://iili.io/33p7y9p.png",
                title: "Chest",
              ),
              const SizedBox(width: 16),
              const CustomRecommendationContainer(
                imageUrl:
                    "https://www.themealdb.com/images/media/meals/2dsltq1560461468.jpg",
                title: "Food",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
