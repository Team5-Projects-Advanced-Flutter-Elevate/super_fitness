import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/widgets/custom_bottom_tab_bar.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/widgets/custom_recommendation_container.dart';

class UpcomingWorkoutsSection extends StatefulWidget {
  const UpcomingWorkoutsSection({super.key});

  @override
  State<UpcomingWorkoutsSection> createState() =>
      _UpcomingWorkoutsSectionState();
}

class _UpcomingWorkoutsSectionState
    extends BaseStatefulWidgetState<UpcomingWorkoutsSection> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                onPressed: () {},
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
          CustomBottomTabBar(
            isScrollable: true,
            horizontalPaddingWhenScrollable: 0,
            horizontalLabelPadding: 8,
            onTabClick: (index) {},
            tabs: [
              const Tab(child: Text("Full Body")),
              const Tab(child: Text("Chest")),
              const Tab(child: Text("Arm")),
              const Tab(child: Text("Arm")),
              const Tab(child: Text("Arm")),
              const Tab(child: Text("Arm")),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            width: screenWidth,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const CustomRecommendationContainer(
                  containerSize: 80,
                  imageUrl: "https://iili.io/33p7y9p.png",
                  title: "Chest",
                  titleContainerTopRadius: 0,
                  titleContainerBottomRadius: 20,
                ),
                const SizedBox(width: 16),
                const CustomRecommendationContainer(
                  containerSize: 80,
                  imageUrl:
                      "https://www.themealdb.com/images/media/meals/2dsltq1560461468.jpg",
                  title: "Food",
                  titleContainerTopRadius: 0,
                  titleContainerBottomRadius: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
