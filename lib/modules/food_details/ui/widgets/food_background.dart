import 'package:flutter/material.dart';

import '../../../../core/colors/app_colors.dart';
import '../view_model/food_details_cubit.dart';

class FoodBackground extends StatelessWidget {
  const FoodBackground({super.key, required this.state});

  final FoodDetailsState state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            image: DecorationImage(
              image: NetworkImage(
                state.foodDetailsEntity?.mealEntity?.strMealThumb ?? '',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, AppColors.black],
              stops: [0.0, 0.8],
            ),
          ),
        ),
      ],
    );
  }
}
