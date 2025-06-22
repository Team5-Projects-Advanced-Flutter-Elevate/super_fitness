import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';

import '../../../../core/widgets/custom_bottom_tab_bar.dart';
import '../../../../core/widgets/custom_item_container.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends BaseStatefulWidgetState<WorkoutsPage> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Workouts'),
          centerTitle: true,
          bottom: CustomBottomTabBar(
            isScrollable: true,
            onTabClick: (index) {
              setState(() {
                currentTabIndex = index;
              });
            },
            tabs: const [
              Tab(child: Text("Full Body")),
              Tab(child: Text("Chest")),
              Tab(child: Text("Arm")),
              Tab(child: Text("Arm")),
              Tab(child: Text("Arm")),
              Tab(child: Text("Full Body")),
              Tab(child: Text("Chest")),
              Tab(child: Text("Arm")),
              Tab(child: Text("Arm")),
              Tab(child: Text("Arm")),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
            ),
            itemBuilder:
                (context, index) => CustomItemContainer(
                  imageUrl: "https://iili.io/33p7y9p.png",
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.26,
                  title: "Chest Exercise".replaceFirst(" ", "\n"),
                ),

            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
