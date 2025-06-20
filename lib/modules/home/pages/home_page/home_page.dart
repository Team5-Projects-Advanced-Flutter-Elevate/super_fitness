import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/core/widgets/custom_bottom_tab_bar.dart';

class HomePage extends BaseStatelessWidget {
  const HomePage({super.key});

  @override
  Widget customBuild(BuildContext context, inherit) {
    return DefaultTabController(
      /// <==== Don't forget to user DefaultTabController
      initialIndex: 0,
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            AssetsPaths.fitnessAppIcon,
            width: inherit.screenWidth * 0.2,
          ),
          centerTitle: true,

          /// ======== First Example Of TAB BAR (scrollable) ==========
          bottom: const CustomBottomTabBar(
            isScrollable: true,
            tabs: [
              Tab(child: Text("Full Body")),
              Tab(child: Text("Chest")),
              Tab(child: Text("Arm")),
              Tab(child: Text("Arm")),
              Tab(child: Text("Arm")),
            ],
          ),
        ),
        body: Builder(
          builder: (context) {
            return TabBarView(
              children: [
                Center(
                  child: Text(
                    "Tab Page1",
                    style: inherit.theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Tab Page2",
                    style: inherit.theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Tab Page3",
                    style: inherit.theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Tab Page4",
                    style: inherit.theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Tab Page5",
                    style: inherit.theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
