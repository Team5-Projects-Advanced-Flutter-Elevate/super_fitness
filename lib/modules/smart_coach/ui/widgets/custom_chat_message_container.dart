import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/widgets/custom_network_cached_image.dart';

class CustomChatMessageContainer extends BaseStatelessWidget {
  final String imagePath;
  final Color messageBackgroundColor;
  final Widget message;

  final bool flipX;

  const CustomChatMessageContainer({
    super.key,
    required this.imagePath,
    required this.messageBackgroundColor,
    required this.message,
    this.flipX = false,
  });

  @override
  Widget customBuild(BuildContext context, inherit) {
    return Transform.flip(
      flipX: flipX,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.flip(
            flipX: inherit.localizationManager.isEnglish ? flipX : false,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.black,
              ),
              padding: const EdgeInsets.all(4),
              child:
                  imagePath.trim().isEmpty
                      ? const Icon(Icons.person)
                      : imagePath.contains("http")
                      ? CustomNetworkCachedImage(
                        imageUrl: imagePath,
                        width: 36,
                        height: 36,
                        errorIcon: Icons.person,
                      )
                      : imagePath.contains(".svg")
                      ? SvgPicture.asset(imagePath)
                      : Image.asset(imagePath),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4, top: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(20),
                  bottomRight: const Radius.circular(20),
                  topRight:
                      inherit.localizationManager.isEnglish
                          ? const Radius.circular(20)
                          : Radius.zero,
                  topLeft:
                      !inherit.localizationManager.isEnglish
                          ? const Radius.circular(20)
                          : Radius.zero,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: messageBackgroundColor),
                    child: Transform.flip(flipX: flipX, child: message),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
