import 'package:flutter/cupertino.dart';
import 'package:super_fitness/modules/food/domain/entities/meal_entity.dart';
import 'package:super_fitness/modules/food_details/ui/widgets/recommendation_section.dart';
import '../view_model/food_details_cubit.dart';
import 'food_video_section.dart';
import 'ingredients_section.dart';

class BuildSuccessState extends StatelessWidget {
  const BuildSuccessState({
    super.key,
    required this.state,
    required this.recommendationList,
  });

  final FoodDetailsState state;
  final List<MealEntity> recommendationList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FoodVideoSection(state: state),
        const SizedBox(height: 16),
        IngredientsSection(state: state),
        const SizedBox(height: 8),
        RecommendationSection(
          state: state,
          recommendationList: recommendationList,
        ),
      ],
    );
  }
}
