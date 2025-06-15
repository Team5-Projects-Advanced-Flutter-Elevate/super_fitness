import 'package:flutter/material.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/authentication/ui/login/login_screen.dart';
import 'package:super_fitness/modules/onboarding/ui/screen/onboarding_screen.dart';

abstract class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    //var args = routeSettings.arguments;
    var name = routeSettings.name;
    try {
      switch (name) {
        case DefinedRoutes.loginScreenRoute:
          return MaterialPageRoute(builder: (context) => const LoginScreen());
        case DefinedRoutes.onboardingScreenRoute:
          return MaterialPageRoute(builder: (context) => const OnboardingScreen());  
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
