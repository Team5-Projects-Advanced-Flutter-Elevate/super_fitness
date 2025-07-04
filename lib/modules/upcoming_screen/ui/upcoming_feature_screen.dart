import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';

class UpcomingFeatureScreen extends BaseStatelessWidget {
  const UpcomingFeatureScreen({super.key});

  @override
  Widget customBuild(BuildContext context, inherit) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPaths.homeBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Upcoming Feature",
            style: inherit.theme.textTheme.titleLarge,
          ),
          centerTitle: true,
          leading: IconButton(
            color: AppColors.white,
            constraints: const BoxConstraints(maxHeight: 25, maxWidth: 25),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.mainColorLight,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Transform.flip(
              flipX: !inherit.localizationManager.isEnglish,
              child: const ImageIcon(AssetImage(AssetsPaths.backIcon)),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Lottie.asset(AssetsPaths.workingDeveloperAnimation),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
