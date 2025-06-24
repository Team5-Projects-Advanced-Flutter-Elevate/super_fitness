import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/widgets/custom_network_cached_image.dart';

class CustomRecommendationContainer extends BaseStatelessWidget {
  final String imageUrl;
  final String title;

  final double containerSize;
  final double titleContainerTopRadius;
  final double titleContainerBottomRadius;

  const CustomRecommendationContainer({
    super.key,
    required this.imageUrl,
    required this.title,
    this.containerSize = 104,
    this.titleContainerTopRadius = 25,
    this.titleContainerBottomRadius = 25,
  });

  @override
  Widget customBuild(BuildContext context, inherit) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: AppColors.black),
          width: containerSize,
          height: containerSize,
          child: CustomNetworkCachedImage(imageUrl: imageUrl),
        ),
        ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(titleContainerBottomRadius),
            top: Radius.circular(titleContainerTopRadius),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: containerSize,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(color: AppColors.black.withAlpha(130)),
              child: AutoSizeText(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: inherit.theme.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
