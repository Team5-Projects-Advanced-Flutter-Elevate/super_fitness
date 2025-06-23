import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/modules/food/ui/view_model/food_view_model.dart';

import '../../../core/constants/assets_paths/assets_paths.dart';
import '../../../core/di/injectable_initializer.dart';

class FoodRecommendationScreen extends StatefulWidget {
  const FoodRecommendationScreen({super.key});

  @override
  State<FoodRecommendationScreen> createState() =>
      _FoodRecommendationScreenState();
}

class _FoodRecommendationScreenState
    extends BaseStatefulWidgetState<FoodRecommendationScreen> {
  final viewModel = getIt.get<FoodViewModel>();
  @override
  void initState() {
    viewModel.onIntent(GetCategoriesIntent());
    //viewModel.onIntent(FilterMealsByCategoryIntent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPaths.authBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //leading: Icon(Icons.back),
          title: Text(
            'data',
            style: theme.textTheme.titleLarge!.copyWith(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
