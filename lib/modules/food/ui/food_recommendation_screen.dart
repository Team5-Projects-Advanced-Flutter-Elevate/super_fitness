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
                  listener: (context, state) {},
                  builder: (context, state) {
                    switch (state.loadFoodCategoriesState) {
                      case LoadFoodCategoriesState.loading:
                      case LoadFoodCategoriesState.initial:
                        return const LoadingStateWidget();
                      case LoadFoodCategoriesState.error:
                        return ErrorStateWidget(error: state.loadCatErrMsg!);
                      case LoadFoodCategoriesState.success:
                        return DefaultTabController(
                          initialIndex: 0,
                          length: 3,
                          child: CustomBottomTabBar(
                            preferredHeight: 35,
                            isScrollable: true,
                            onTabClick: (index) {},
                            tabs:
                                state.foodCategoriesList!
                                    .map(
                                      (element) => Tab(
                                        child: Text(element.strCategory ?? ''),
                                        iconMargin: const EdgeInsets.all(20),
                                      ),
                                    )
                                    .toList(),
                          ),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
