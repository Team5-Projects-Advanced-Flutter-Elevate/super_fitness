import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/modules/onboarding/ui/widget/onboarding_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends BaseStatefulWidgetState<OnboardingScreen> {
  static final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  void _navigateToLogin() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      DefinedRoutes.loginScreenRoute,
      (_) => false,
    );
  }

  void _handleNextPress() {
    if (_currentPage < onboardingPages.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: Durations.long1,
        curve: Curves.linear,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _handleBackPress() {
    if (_currentPage > 0) {
      // Move to the previous page
      _pageController.animateToPage(
        _currentPage - 1,
        duration: Durations.long1,
        curve: Curves.linear,
      );
    }
  }

  final List<Widget> onboardingPages = [
    const OnboardingCard(
      image: 'assets/images/onboarding_first.png',
      title: 'The Price Of Excellence\n Is Discipline',
      description:
          'Lorem ipsum dolor sit amet consectetur. Eu urna\n ut gravida quis id pretium purus. Mauris massa ',
      buttonText: 'Next',
    ),
    const OnboardingCard(
      image: 'assets/images/onboarding_second.png',
      title: 'Fitness Has Never Been\n So Much Fun',
      description:
          'Lorem ipsum dolor sit amet consectetur. Eu urna\n ut gravida quis id pretium purus. Mauris massa ',
      buttonText: 'Next',
    ),
    const OnboardingCard(
      image: 'assets/images/onboarding_third.png',
      title: 'NO MORE EXCUSES\nDo It Now',
      description:
          'Lorem ipsum dolor sit amet consectetur. Eu urna\n ut gravida quis id pretium purus. Mauris massa ',
      buttonText: 'Done',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPaths.onboardingBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.030),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: onboardingPages,
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                effect: const ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  dotColor: Color(0xffD9D9D9),
                  activeDotColor: Colors.deepOrange,
                ),
                count: onboardingPages.length,
                onDotClicked: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: Durations.long1,
                    curve: Curves.linear,
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child:
                    _currentPage == 0
                        ? MaterialButton(
                          shape: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide.none,
                          ),
                          color: Colors.deepOrange,
                          minWidth: screenWidth * 0.9,
                          height: 44,
                          onPressed: _handleNextPress,
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              shape: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              color: Colors.transparent,
                              minWidth: screenWidth * 0.35,
                              height: 44,
                              onPressed: _handleBackPress,
                              child: Text(
                                'Back',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(
                                    context,
                                  ).textScaler.scale(16),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            MaterialButton(
                              shape: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              color: Colors.deepOrange,
                              minWidth: screenWidth * 0.35,
                              height: 44,
                              onPressed: _handleNextPress,
                              child: Text(
                                _currentPage == onboardingPages.length - 1
                                    ? 'Do It'
                                    : 'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(
                                    context,
                                  ).textScaler.scale(16),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
