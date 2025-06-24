import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/food/ui/view_model/food_state.dart';
import 'package:super_fitness/modules/food/ui/view_model/food_view_model.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/assets_paths/assets_paths.dart';
import '../../../core/di/injectable_initializer.dart';
import '../../../core/widgets/custom_bottom_tab_bar.dart';
import '../../../core/widgets/custom_item_container.dart';
import '../../../core/widgets/error_state_widget.dart';

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
      child: SafeArea(
        child: Scaffold(
          body: BlocProvider(
            create: (context) => viewModel,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.mainColorLight,
                      child: const ImageIcon(
                        AssetImage(AssetsPaths.backIcon),
                        size: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Food Recommendation',
                      style: theme.textTheme.titleLarge,
                    ),
                    const Spacer(flex: 6),
                  ],
                ),
                const SizedBox(height: 20),
                BlocConsumer<FoodViewModel, FoodState>(
                  listener: (context, state) {
                    switch (state.loadFoodCategoriesState) {
                      case LoadFoodCategoriesState.loading:
                      case LoadFoodCategoriesState.initial:
                      case LoadFoodCategoriesState.idle:
                        break;
                      case LoadFoodCategoriesState.error:
                        break;
                      case LoadFoodCategoriesState.success:
                        viewModel.onIntent(
                          FilterMealsByCategoryIntent(
                            selectedCategoryName: state.selectedCategory!,
                          ),
                        );
                        break;
                    }
                  },
                  builder: (context, state) {
                    switch (state.loadFoodCategoriesState) {
                      case LoadFoodCategoriesState.loading:
                      case LoadFoodCategoriesState.initial:
                        return const LoadingStateWidget();
                      case LoadFoodCategoriesState.error:
                        return ErrorStateWidget(error: state.loadCatErrMsg!);
                      case LoadFoodCategoriesState.success:
                      case LoadFoodCategoriesState.idle:
                        return DefaultTabController(
                          initialIndex: 0,
                          length: state.foodCategoriesList!.length,
                          child: CustomBottomTabBar(
                            preferredHeight: 35,
                            isScrollable: true,
                            onTabClick: (index) {
                              viewModel.onIntent(
                                FilterMealsByCategoryIntent(
                                  selectedCategoryName:
                                      state
                                          .foodCategoriesList![index]
                                          .strCategory!,
                                ),
                              );
                            },
                            tabs:
                                state.foodCategoriesList!
                                    .map(
                                      (element) => Tab(
                                        child: Text(element.strCategory ?? ''),
                                      ),
                                    )
                                    .toList(),
                          ),
                        );
                    }
                  },
                ),
                Expanded(
                  child: BlocBuilder<FoodViewModel, FoodState>(
                    builder: (context, state) {
                      switch (state.filterFoodState) {
                        case FilterFoodState.initial:
                        case FilterFoodState.loading:
                          return const LoadingStateWidget();
                        case FilterFoodState.success:
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 24,
                            ),
                            child:
                                state.mealsList!.isEmpty
                                    ? Center(
                                      child: Text(
                                        'no food',
                                        style: theme.textTheme.titleLarge,
                                      ),
                                    )
                                    : GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 18,
                                            mainAxisSpacing: 18,
                                          ),
                                      itemBuilder:
                                          (context, index) =>
                                              CustomItemContainer(
                                                imageUrl:
                                                    state
                                                        .mealsList?[index]
                                                        .thumbnailUrl ??
                                                    '',
                                                width: screenWidth * 0.6,
                                                height: screenHeight * 0.26,
                                                title:
                                                    state
                                                        .mealsList?[index]
                                                        .name ??
                                                    '',
                                              ),

                                      itemCount: state.mealsList!.length,
                                    ),
                          );

                        case FilterFoodState.error:
                          return ErrorStateWidget(
                            error: state.filterFoodErrMsg!,
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
