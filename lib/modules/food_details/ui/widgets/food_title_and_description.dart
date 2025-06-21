import 'package:flutter/material.dart';

import '../view_model/food_details_cubit.dart';

class FoodTitleAndDescription extends StatelessWidget {
  const FoodTitleAndDescription({super.key, required this.state});

  final FoodDetailsState state;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      left: 16,
      right: 16,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.foodDetailsEntity?.mealEntity?.strMeal ?? '',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontSize: 24),
            ),
            SizedBox(
              height: 70,
              child: SingleChildScrollView(
                child: Text(
                  state.foodDetailsEntity?.mealEntity?.strInstructions ?? '',
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
