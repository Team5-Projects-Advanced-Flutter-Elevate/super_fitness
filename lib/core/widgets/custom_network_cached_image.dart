import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';

import '../colors/app_colors.dart';

class CustomNetworkCachedImage extends BaseStatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double radius;

  final BoxFit fit;

  const CustomNetworkCachedImage({
    super.key,
    required this.imageUrl,
    this.radius = 20,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  Widget customBuild(BuildContext context, inherit) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        fit: fit,
        placeholder: (context, url) {
          return Shimmer(
            duration: const Duration(seconds: 1),
            //Default value
            interval: const Duration(seconds: 1),
            //Default value: Duration(seconds: 0)
            color: Colors.white,
            //Default value
            colorOpacity: 0.7,
            //Default value
            enabled: true,
            //Default value
            direction:
                inherit.localizationManager.isEnglish
                    ? const ShimmerDirection.fromLTRB()
                    : const ShimmerDirection.fromRTLB(),
            //Default Value
            child: Container(
              color: AppColors.black[30]!.withAlpha(200),
              width: width,
              height: height,
            ),
          );
        },
        errorWidget:
            (context, url, error) => Container(
              width: width,
              height: height,
              color: AppColors.black.withAlpha(130),
              child: Icon(
                Icons.error_outline,
                color: AppColors.mainColorLight,
                size: 30,
              ),
            ),
      ),
    );
  }
}
