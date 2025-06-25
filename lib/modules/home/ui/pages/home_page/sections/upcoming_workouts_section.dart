import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/widgets/custom_bottom_tab_bar.dart';
import 'package:super_fitness/core/widgets/error_state_widget.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/view_model/home_page_state.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/view_model/home_page_view_model.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/widgets/custom_recommendation_container.dart';
import 'package:super_fitness/modules/home/ui/view_model/home_view_model.dart';

class UpcomingWorkoutsSection extends StatefulWidget {
  const UpcomingWorkoutsSection({super.key});

  @override
  State<UpcomingWorkoutsSection> createState() =>
      _UpcomingWorkoutsSectionState();
}

class _UpcomingWorkoutsSectionState
    extends BaseStatefulWidgetState<UpcomingWorkoutsSection> {
  late HomePageViewModel homePageViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homePageViewModel = Provider.of<HomePageViewModel>(context);
  }

  bool didMuscleWorkoutsLoadedOnce = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              appLocalizations.upcomingWorkouts,
              textAlign: TextAlign.start,
              style: theme.textTheme.titleMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Provider.of<HomeViewModel>(
                  context,
                  listen: false,
                ).navigateToPage(2);
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
          height: 140,
          width: screenWidth,
          child: BlocBuilder<HomePageViewModel, HomePageState>(
            buildWhen: (previous, current) {
              if (previous.musclesGroupsStatus != current.musclesGroupsStatus) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              switch (state.musclesGroupsStatus) {
                case Status.idle:
                  return const SizedBox();
                case Status.loading:
                  return const LoadingStateWidget();
                case Status.success:
                  var musclesGroups = state.musclesGroups ?? [];
                  if (musclesGroups.isNotEmpty &&
                      !didMuscleWorkoutsLoadedOnce) {
                    homePageViewModel.doIntent(
                      GetMuscleWorkouts(
                        musclesGroupId: musclesGroups.first.id ?? "",
                      ),
                    );
                    didMuscleWorkoutsLoadedOnce = true;
                  }
                  return DefaultTabController(
                    initialIndex: 0,
                    length: musclesGroups.length,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBottomTabBar(
                          isScrollable: true,
                          horizontalPaddingWhenScrollable: 0,
                          horizontalLabelPadding: 8,
                          onTabClick: (index) {
                            homePageViewModel.doIntent(
                              GetMuscleWorkouts(
                                musclesGroupId: musclesGroups[index].id ?? "",
                              ),
                            );
                          },
                          tabs: List.generate(musclesGroups.length, (index) {
                            return Tab(
                              child: Text(
                                musclesGroups[index].name ??
                                    appLocalizations.unknown,
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: BlocBuilder<HomePageViewModel, HomePageState>(
                            buildWhen: (previous, current) {
                              if (previous.muscleWorkoutsStatus !=
                                  current.muscleWorkoutsStatus) {
                                return true;
                              }
                              return false;
                            },
                            builder: (context, state) {
                              switch (state.muscleWorkoutsStatus) {
                                case Status.idle:
                                  return const SizedBox();
                                case Status.loading:
                                  return const LoadingStateWidget();
                                case Status.success:
                                  var muscleWorkouts = state.muscles ?? [];
                                  return muscleWorkouts.isEmpty
                                      ? Center(
                                        child: Text(
                                          appLocalizations.noData,
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(fontSize: 20),
                                        ),
                                      )
                                      : ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: muscleWorkouts.length,
                                        itemBuilder: (context, index) {
                                          return CustomRecommendationContainer(
                                            containerSize: 80,
                                            imageUrl:
                                                muscleWorkouts[index].image ??
                                                '',
                                            title:
                                                muscleWorkouts[index].name ??
                                                '',
                                            titleContainerTopRadius: 0,
                                            titleContainerBottomRadius: 20,
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(width: 16);
                                        },
                                      );
                                case Status.error:
                                  return ErrorStateWidget(
                                    error: state.musclesGroupsError!,
                                  );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                case Status.error:
                  return ErrorStateWidget(error: state.musclesGroupsError!);
              }
            },
          ),
        ),
      ],
    );
  }
}
