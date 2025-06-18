import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/modules/layout/chat/chat_screen.dart';
import 'package:super_fitness/modules/layout/home/home_screen.dart';
import 'package:super_fitness/modules/layout/profile/profile_screen.dart';
import 'package:super_fitness/modules/layout/workout/workout_screen.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';

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
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: screens,
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: 
          CrystalNavigationBar(
            currentIndex: currentScreen,
            backgroundColor: AppColors.black,
            onTap: (value) {
              setState(() {
                currentScreen = value;
              });
              controller.jumpToPage(currentScreen);
            },
            items: [
              CrystalNavigationBarItem(
                unselectedColor: AppColors.white,
                icon: Icons.home_outlined,
                selectedColor: Colors.deepOrange,
                badge: Badge(
                  label: Text(
                    "Home",
                    style: TextStyle(color: currentScreen == 0 ? Colors.deepOrange : AppColors.white,),
                  ),
                ),
              ),
              CrystalNavigationBarItem(
                unselectedColor: AppColors.white,
                icon: Icons.chat,
                selectedColor: Colors.deepOrange,
                badge: Badge(
                  label: Text(
                    "Chat",
                    style: TextStyle(color: currentScreen == 1 ? Colors.deepOrange : AppColors.white,),
                  ),
                ),
              ),
              CrystalNavigationBarItem(
                unselectedColor: AppColors.white,
                icon: Icons.sports_gymnastics,
                selectedColor: Colors.deepOrange,
                badge: Badge(
                  label: Text(
                    "Workouts",
                    style: TextStyle(color: currentScreen == 2 ? Colors.deepOrange : AppColors.white,),
                  ),
                ),
              ),
              CrystalNavigationBarItem(
                unselectedColor: AppColors.white,
                icon: Icons.person_outline,
                selectedColor: Colors.deepOrange,
                badge: Badge(
                  label: Text(
                    "Profile",
                    style: TextStyle(color: currentScreen == 3 ? Colors.deepOrange : AppColors.white,),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}