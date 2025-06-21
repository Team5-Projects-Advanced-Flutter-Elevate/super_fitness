import 'package:flutter/material.dart';

import '../../../../core/bases/base_inherited_widget.dart';
import '../../../../core/bases/base_statless_widget.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';

class MyBackButton extends BaseStatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Positioned(
      top: 40,
      child: IconButton(
        color: AppColors.white,
        constraints: const BoxConstraints(maxHeight: 25, maxWidth: 25),
        style: IconButton.styleFrom(backgroundColor: AppColors.mainColorLight),
        onPressed: () {},
        icon: Transform.flip(
          flipX: !inherit.localizationManager.isEnglish,
          child: const ImageIcon(AssetImage(AssetsPaths.backIcon)),
        ),
      ),
    );
  }
}
