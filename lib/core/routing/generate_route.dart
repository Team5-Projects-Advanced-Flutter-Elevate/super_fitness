import 'package:flutter/material.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/authentication/ui/login/login_screen.dart';
import 'package:super_fitness/modules/authentication/ui/register/all_register_feature.dart';
import 'package:super_fitness/modules/home/home_screen.dart';
import 'package:super_fitness/modules/onboarding/ui/screen/onboarding_screen.dart';

import '../../modules/authentication/ui/forget_password/view/forget_password_screen.dart';

abstract class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    //var args = routeSettings.arguments;
    var name = routeSettings.name;
    try {
      switch (name) {
        case DefinedRoutes.loginScreenRoute:
          return MaterialPageRoute(builder: (context) => const LoginScreen());
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
