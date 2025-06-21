import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/modules/home/pages/ai_chat_page/ai_chat_page.dart';
import 'package:super_fitness/modules/home/pages/home_page/home_page.dart';
import 'package:super_fitness/modules/home/pages/profile_page/profile_page.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/workouts_page.dart';
import 'package:super_fitness/modules/home/view_model/home_view_model.dart';

import '../../core/di/injectable_initializer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStatefulWidgetState<HomeScreen> {
  final HomeViewModel homeViewModel = getIt.get<HomeViewModel>();
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      const HomePage(),
      const AiChatPage(),
      const WorkoutsPage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPaths.homeBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Provider(
        create: (context) => homeViewModel,
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                PageView(
                  controller: homeViewModel.pageViewController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: pages,
                  onPageChanged: (value) {
                    homeViewModel.currentPageIndexNotifier.value = value;
                  },
                ),
                Positioned(
                  bottom: screenHeight * 0.04,
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 12, sigmaX: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.black.withAlpha(190),
                          ),
                          child: ValueListenableBuilder(
                            valueListenable:
                                homeViewModel.currentPageIndexNotifier,
                            builder: (context, currentIndex, child) {
                              return BottomNavigationBar(
                                type: BottomNavigationBarType.fixed,
                                items: [
                                  BottomNavigationBarItem(
                                    icon: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14.0,
                                      ),
                                      child: ImageIcon(
                                        AssetImage(AssetsPaths.homeIcon),
                                      ),
                                    ),
                                    label: appLocalizations.explore,
                                  ),
                                  BottomNavigationBarItem(
                                    icon: const ImageIcon(
                                      AssetImage(AssetsPaths.chatAiIcon),
                                      size: 30,
                                    ),
                                    label: appLocalizations.aiChat,
                                  ),
                                  BottomNavigationBarItem(
                                    icon: const ImageIcon(
                                      AssetImage(AssetsPaths.dumbbellIcon),
                                      size: 45,
                                    ),
                                    label: appLocalizations.workouts,
                                  ),
                                  BottomNavigationBarItem(
                                    icon: const ImageIcon(
                                      AssetImage(AssetsPaths.profileIcon),
                                    ),
                                    label: appLocalizations.profile,
                                  ),
                                ],
                                currentIndex: currentIndex,
                                onTap: (value) {
                                  homeViewModel.currentPageIndexNotifier.value =
                                      value;
                                  homeViewModel.pageViewController.jumpToPage(
                                    value,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
