import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/widgets/custom_network_cached_image.dart';

class CustomItemContainer extends BaseStatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final String title;
  final BoxFit fit;

  const CustomItemContainer({
    super.key,
    required this.imageUrl,
    required this.title,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  Widget customBuild(BuildContext context, inherit) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: CustomNetworkCachedImage(
            fit: fit,
            imageUrl: imageUrl,
            width: width,
            height: height,
          ),
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.black.withAlpha(125),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: inherit.theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
