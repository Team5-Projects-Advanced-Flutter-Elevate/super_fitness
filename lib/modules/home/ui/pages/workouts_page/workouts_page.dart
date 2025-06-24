import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';
import 'package:super_fitness/core/widgets/custom_item_container.dart';
import 'package:super_fitness/core/widgets/custom_network_cached_image.dart';

class WorkoutsPage extends BaseStatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget customBuild(BuildContext context, inherit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: inherit.screenHeight * 0.1),
        Text(
          "CustomNetwork\nCachedImage",
          textAlign: TextAlign.center,
          style: inherit.theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        CustomNetworkCachedImage(
          imageUrl:
              "https://www.themealdb.com/images/media/meals/2dsltq1560461468.jpg",
          width: inherit.screenWidth * 0.6,
          height: inherit.screenHeight * 0.26,
        ),
        SizedBox(height: inherit.screenHeight * 0.02),
        Text(
          "CustomItemContainer",
          style: inherit.theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        CustomItemContainer(
          imageUrl: "https://iili.io/33p7y9p.png",
          width: inherit.screenWidth * 0.6,
          height: inherit.screenHeight * 0.26,
          title: "Chest Exercise".replaceFirst(" ", "\n"),
        ),
      ],
    );
  }
}
