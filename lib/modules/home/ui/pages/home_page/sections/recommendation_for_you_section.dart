import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/core/widgets/error_state_widget.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/food/ui/view_model/params/food_recommendation_screen_params.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/view_model/home_page_state.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/view_model/home_page_view_model.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/widgets/custom_recommendation_container.dart';

class RecommendationForYouSection extends StatefulWidget {
  const RecommendationForYouSection({super.key});

  @override
  State<RecommendationForYouSection> createState() =>
      _RecommendationForYouSectionState();
}

class _RecommendationForYouSectionState
    extends BaseStatefulWidgetState<RecommendationForYouSection> {
  late HomePageViewModel homePageViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homePageViewModel = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              appLocalizations.recommendationForYou,
              textAlign: TextAlign.start,
              style: theme.textTheme.titleMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  DefinedRoutes.foodRecommendationScreenRoute,
                );
              },
              child: Text(
                appLocalizations.seeAll,
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
          child: BlocBuilder<HomePageViewModel, HomePageState>(
            buildWhen: (previous, current) {
              if (previous.foodCategoriesStatus !=
                  current.foodCategoriesStatus) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              switch (state.foodCategoriesStatus) {
                case Status.idle:
                  return const SizedBox();
                case Status.loading:
                  return const LoadingStateWidget();
                case Status.success:
                  var foodCategoryEntities = state.foodCategoryEntities ?? [];
                  return foodCategoryEntities.isEmpty
                      ? Center(
                        child: Text(
                          appLocalizations.noData,
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      )
                      : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: foodCategoryEntities.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: WidgetStateColor.transparent,
                            overlayColor: WidgetStateColor.transparent,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                DefinedRoutes.foodRecommendationScreenRoute,
                                arguments: FoodRecommendationScreenParams(
                                  initialTabIndex: index,
                                  selectedCategory:
                                      foodCategoryEntities[index].strCategory,
                                ),
                              );
                            },
                            child: CustomRecommendationContainer(
                              imageUrl:
                                  foodCategoryEntities[index]
                                      .strCategoryThumb ??
                                  "",
                              title:
                                  foodCategoryEntities[index].strCategory ?? "",
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 16);
                        },
                      );
                case Status.error:
                  return ErrorStateWidget(error: state.foodCategoriesError!);
              }
            },
          ),
        ),
      ],
    );
  }
}
