import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/widgets/error_state_widget.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/food_details/ui/view_model/food_details_cubit.dart';
import 'package:super_fitness/modules/food_details/ui/widgets/food_video_section.dart';
import 'package:super_fitness/modules/food_details/ui/widgets/ingredients_section.dart';
import 'package:super_fitness/modules/food_details/ui/widgets/recommendation_section.dart';
import '../../../core/bases/base_stateful_widget_state.dart';
import '../../../core/constants/assets_paths/assets_paths.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState
    extends BaseStatefulWidgetState<FoodDetailsScreen> {
  FoodDetailsCubit foodDetailsCubit = getIt<FoodDetailsCubit>();

  @override
  void initState() {
    super.initState();
    foodDetailsCubit.doIntent(GetFoodDetailsIntent('52949'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => foodDetailsCubit,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPaths.homeBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          body: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
            builder: (context, state) {
              switch (state.getFoodDetailsStatus) {
                case GetFoodDetailsStatus.initial:
                case GetFoodDetailsStatus.loading:
                  return const LoadingStateWidget();
                case GetFoodDetailsStatus.success:
                  return buildSuccess(state);
                case GetFoodDetailsStatus.error:
                  return ErrorStateWidget(error: state.getFoodDetailsError!);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildSuccess(FoodDetailsState state) {
    return Column(
      children: [
        FoodVideoSection(state: state),
        const SizedBox(height: 16),
        IngredientsSection(state: state),
        const SizedBox(height: 8),
        const RecommendationSection(),
      ],
    );
  }
}
