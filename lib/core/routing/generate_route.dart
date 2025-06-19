import 'package:flutter/material.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/authentication/ui/login/login_screen.dart';
import 'package:super_fitness/modules/layout/chat/chat_screen.dart';
import 'package:super_fitness/modules/layout/home/home_screen.dart';
import 'package:super_fitness/modules/layout/layout_screen.dart';
import 'package:super_fitness/modules/layout/profile/profile_screen.dart';
import 'package:super_fitness/modules/layout/workout/workout_screen.dart';

abstract class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    //var args = routeSettings.arguments;
    var name = routeSettings.name;
    try {
      switch (name) {
        case DefinedRoutes.loginScreenRoute:
          return MaterialPageRoute(builder: (context) => const LoginScreen());
        case DefinedRoutes.homeScreenRoute:
          return MaterialPageRoute(builder: (context) => const HomeScreen());
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
        default:
          return _errorRoute();
      }
    } catch (e) {
      return _errorRoute();
    }
  }

  static List<Route<dynamic>> onGenerateInitialRoutes({
    String? initialRoute,
    LoginDataResponseEntity? loginInfo,
  }) {
    return [
      if (loginInfo != null)
        MaterialPageRoute(
          builder: (context) => const SizedBox(),
        ) // LayoutScreen()
      else
        MaterialPageRoute(builder: (context) => const LayoutScreen()),
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
