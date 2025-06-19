import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';

class OnboardingCard extends StatefulWidget {
  const OnboardingCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  final String image;
  final String title;
  final String description;
  final String buttonText;

  @override
  State<OnboardingCard> createState() => _OnboardingCardState();
}

class _OnboardingCardState extends BaseStatefulWidgetState<OnboardingCard> {
  void _navigateToLogin() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      DefinedRoutes.loginScreenRoute,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //SizedBox(height: screenHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.05),
                child: GestureDetector(
                  onTap: _navigateToLogin,
                  child: Text(
                    appLocalizations.skip,
                    style: TextStyle(
                      color: const Color(0xffD9D9D9),
                      fontSize: MediaQuery.of(context).textScaler.scale(14),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: screenHeight * 0.55),
            child: Image.asset(widget.image, fit: BoxFit.contain),
          ),
          SizedBox(height: screenHeight * 0.01),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).textScaler.scale(25),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).textScaler.scale(16),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
