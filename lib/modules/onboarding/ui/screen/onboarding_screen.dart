import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
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
    if (_currentPage < onboardingPages(context).length - 1) {
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
      _pageController.animateToPage(
        _currentPage - 1,
        duration: Durations.long1,
        curve: Curves.linear,
      );
    }
  }

  List<Widget> onboardingPages(BuildContext context) {
    return [
      OnboardingCard(
        image: 'assets/images/onboarding_first.png',
        title:
            '${appLocalizations.priceOfExcellence}  \n  ${appLocalizations.isDiscipline}',
        description:
            '${appLocalizations.loremIpsumDolorSitAmetConsectetureuUrna}  \n  ${appLocalizations.utGravidaQuisIdPretiumPurusMaurisMassa}',
        buttonText: appLocalizations.next,
      ),
      OnboardingCard(
        image: 'assets/images/onboarding_second.png',
        title:
            '${appLocalizations.fitnessHasNeverBeenSo} \n ${appLocalizations.muchFun}',
        description:
            '${appLocalizations.loremIpsumDolorSitAmetConsectetureuUrna}  \n  ${appLocalizations.utGravidaQuisIdPretiumPurusMaurisMassa}',
        buttonText: appLocalizations.next,
      ),
      OnboardingCard(
        image: 'assets/images/onboarding_third.png',
        title:
            '${appLocalizations.noMoreExecuses}  \n  ${appLocalizations.doItNow}',
        description:
            '${appLocalizations.loremIpsumDolorSitAmetConsectetureuUrna}  \n  ${appLocalizations.utGravidaQuisIdPretiumPurusMaurisMassa}',
        buttonText: appLocalizations.doIt,
      ),
    ];
  }

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
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.030),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.04),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      children: onboardingPages(context),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: screenHeight * 0.40,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      color: AppColors.black.withAlpha(30),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.02,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (onboardingPages(context)[_currentPage]
                                    as OnboardingCard)
                                .title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(
                                context,
                              ).textScaler.scale(25),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            (onboardingPages(context)[_currentPage]
                                    as OnboardingCard)
                                .description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(
                                context,
                              ).textScaler.scale(16),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          SmoothPageIndicator(
                            controller: _pageController,
                            effect: const ExpandingDotsEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              dotColor: Color(0xffD9D9D9),
                              activeDotColor: Colors.deepOrange,
                            ),
                            count: onboardingPages(context).length,
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
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                            ),
                            child:
                                _currentPage == 0
                                    ? MaterialButton(
                                      shape: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        borderSide: BorderSide.none,
                                      ),
                                      color: Colors.deepOrange,
                                      minWidth: screenWidth,
                                      height: screenHeight * 0.05,
                                      onPressed: _handleNextPress,
                                      child: Text(
                                        appLocalizations.next,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                    : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          minWidth: screenWidth * 0.23,
                                          height: 44,
                                          onPressed: _handleBackPress,
                                          child: Text(
                                            appLocalizations.back,
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
                                          minWidth: screenWidth * 0.23,
                                          height: 44,
                                          onPressed: _handleNextPress,
                                          child: Text(
                                            _currentPage ==
                                                    onboardingPages(
                                                          context,
                                                        ).length -
                                                        1
                                                ? appLocalizations.doIt
                                                : appLocalizations.next,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
