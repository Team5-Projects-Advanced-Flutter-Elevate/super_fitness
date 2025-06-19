import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/modules/layout/chat/chat_screen.dart';
import 'package:super_fitness/modules/layout/home/home_screen.dart';
import 'package:super_fitness/modules/layout/profile/profile_screen.dart';
import 'package:super_fitness/modules/layout/workout/workout_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  static const String routeName = 'Layout Screen';

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends BaseStatefulWidgetState<LayoutScreen> {
  late PageController controller;
  int currentScreen = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ChatScreen(),
    const WorkoutsScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPaths.appSectionIcon),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        extendBody: true,
        body: screens[currentScreen],
        bottomNavigationBar: Container(
          height: screenHeight * 0.080,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).padding.horizontal * 0.016,
            vertical: MediaQuery.of(context).padding.vertical * 0.004,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsPaths.appSectionIcon),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
              currentIndex: currentScreen,
              onTap: (index) {
                setState(() {
                  currentScreen = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: AppColors.white,
              backgroundColor: AppColors.black,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage(AssetsPaths.homeIcon)),
                  label: appLocalizations.home,
                ),
                BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage(AssetsPaths.chatIcon)),
                  label: appLocalizations.chatAI,
                ),
                BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage(AssetsPaths.workoutIcon)),
                  label: appLocalizations.workouts,
                ),
                BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage(AssetsPaths.profileIcon)),
                  label: appLocalizations.profile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
