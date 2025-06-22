import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/widgets/custom_network_cached_image.dart';
import 'package:super_fitness/modules/home/pages/home_page/sections/categories_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseStatefulWidgetState<HomePage> {
  String userName = "Ahmed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Hi $userName,\n",
                style: theme.textTheme.titleMedium,
              ),
              TextSpan(
                text: "Let’s Start Your Day",
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
        actions: [
          Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: const CustomNetworkCachedImage(
              imageUrl:
                  "https://fitness.elevateegy.com/uploads/default-profile.png",
              width: 45,
              height: 45,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [CategoriesSection()]),
      ),
    );
  }
}
