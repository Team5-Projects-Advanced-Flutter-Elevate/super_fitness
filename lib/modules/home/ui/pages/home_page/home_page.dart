import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/widgets/custom_network_cached_image.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/sections/categories_section.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/sections/recommendation_for_you_section.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/sections/recommendation_to_day_section.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/sections/upcoming_workouts_section.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/view_model/home_page_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseStatefulWidgetState<HomePage> {
  String userName = "Ahmed";

  final HomePageViewModel homePageViewModel = getIt.get<HomePageViewModel>();

  @override
  void initState() {
    super.initState();
    homePageViewModel.doIntent(LoadHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homePageViewModel,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 8,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Hi $userName,\n",
                  style: theme.textTheme.titleMedium,
                ),
                TextSpan(
                  text: "Let’s Start Your Day",
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
          actions: [
            Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const CustomNetworkCachedImage(
                imageUrl:
                    "https://fitness.elevateegy.com/uploads/default-profile.png",
                width: 45,
                height: 45,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const CategoriesSection(),
              SizedBox(height: screenHeight * 0.025),
              const RecommendationToDaySection(),
              SizedBox(height: screenHeight * 0.025),
              const UpcomingWorkoutsSection(),
              SizedBox(height: screenHeight * 0.025),
              const RecommendationForYouSection(),
              SizedBox(height: screenHeight * 0.15),
            ],
          ),
        ),
      ),
    );
  }
}
