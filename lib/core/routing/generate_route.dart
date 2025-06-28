import 'package:flutter/material.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/authentication/ui/login/login_screen.dart';
import 'package:super_fitness/modules/authentication/ui/register/all_register_feature.dart';
import 'package:super_fitness/modules/exercise/ui/screen/exercise_screen.dart';
import 'package:super_fitness/modules/exercise/ui/screen/video_player.dart';
import 'package:super_fitness/modules/food/ui/food_recommendation_screen.dart';
import 'package:super_fitness/modules/food/ui/view_model/params/food_recommendation_screen_params.dart';
import 'package:super_fitness/modules/home/ui/home_screen.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/change_password_page.dart';
import 'package:super_fitness/modules/layout/chat/chat_screen.dart';
import 'package:super_fitness/modules/layout/layout_screen.dart';
import 'package:super_fitness/modules/layout/profile/profile_screen.dart';
import 'package:super_fitness/modules/layout/workout/workout_screen.dart';
import 'package:super_fitness/modules/onboarding/ui/screen/onboarding_screen.dart';
import 'package:super_fitness/modules/upcoming_screen/ui/upcoming_feature_screen.dart';

import '../../modules/authentication/ui/forget_password/view/forget_password_screen.dart';
import '../../modules/food_details/ui/food_details_screen.dart';

abstract class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    var args = routeSettings.arguments;
    var name = routeSettings.name;
    try {
      switch (name) {
        case DefinedRoutes.loginScreenRoute:
          return MaterialPageRoute(builder: (context) => const LoginScreen());
        case DefinedRoutes.chatScreenRoute:
          return MaterialPageRoute(builder: (context) => const ChatScreen());
        case DefinedRoutes.workoutsScreenRoute:
          return MaterialPageRoute(
            builder: (context) => const WorkoutsScreen(),
          );
        case DefinedRoutes.profileScreenRoute:
          return MaterialPageRoute(builder: (context) => const ProfileScreen());
        case DefinedRoutes.layoutScreenRoute:
          return MaterialPageRoute(builder: (context) => const LayoutScreen());
        case DefinedRoutes.forgetPasswordScreenRoute:
          return MaterialPageRoute(
            builder: (context) => const ForgetPasswordScreen(),
          );
        case DefinedRoutes.onboardingScreenRoute:
          return MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          );
        case DefinedRoutes.allRegisterFeature:
          return MaterialPageRoute(
            builder: (context) => const AllRegisterFeature(),
          );
        case DefinedRoutes.homeScreenRoute:
          return MaterialPageRoute(builder: (context) => const HomeScreen());
        case DefinedRoutes.upcomingFeatureScreen:
          return MaterialPageRoute(
            builder: (context) => const UpcomingFeatureScreen(),
          );
        case DefinedRoutes.foodRecommendationScreenRoute:
          return MaterialPageRoute(
            builder:
                (context) => FoodRecommendationScreen(
                  params: (args as FoodRecommendationScreenParams?),
                ),
          );
        case DefinedRoutes.exerciseScreenRoute:
          return MaterialPageRoute(
            builder: (context) => ExerciseScreen(muscleId: args as String),
          );
        case DefinedRoutes.playerScreenRoute:
          return MaterialPageRoute(
            builder: (context) => PlayerScreen(url: args as String),
          );
        case DefinedRoutes.foodRecommendation:
          return MaterialPageRoute(
            builder: (context) => const FoodRecommendationScreen(),
          );
        case DefinedRoutes.foodDetails:
          var args = routeSettings.arguments;
          return MaterialPageRoute(
            builder:
                (context) =>
                    FoodDetailsScreen(arguments: args as FoodDetailsArguments),
          );
        case DefinedRoutes.changePasswordRoute:
          return MaterialPageRoute(
            builder: (context) => const ChangePasswordScreen(),
          );
        default:
          return _errorRoute();
      }
    } catch (e) {
      return _errorRoute();
    }
  }

  static List<Route<dynamic>> onGenerateInitialRoutes({
    String? initialRoute,
    LoginEntity? loginInfo,
  }) {
    return [
      if (loginInfo != null)
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ) // LayoutScreen()
      else
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      // OnboardingScreen()
    ];
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Material(
          child: Container(
            color: Colors.red,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Error! You Have Navigated To A Wrong Route. Or Navigated With Wrong Arguments",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
