import 'package:flutter/material.dart';

import '../../../../../../../core/bases/base_inherited_widget.dart';
import '../../../../../../../core/bases/base_statless_widget.dart';
import '../../../../../../../core/colors/app_colors.dart';

class ProfileItem extends BaseStatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.switchWidget,
    this.isSwitch = false,
    this.onTrailingTap,
  });

  final String leadingIcon;
  final String title;
  final bool isSwitch;
  final Widget? switchWidget;
  final VoidCallback? onTrailingTap;

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Row(
      children: [
        ImageIcon(AssetImage(leadingIcon), color: AppColors.mainColorLight),
        const SizedBox(width: 16),
        isSwitch
            ? RichText(
              text: TextSpan(
                text: title,
                style: inherit.theme.textTheme.titleLarge?.copyWith(
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: ' ( ',
                    style: inherit.theme.textTheme.titleLarge?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: inherit.appLocalizations.english,
                    style: inherit.theme.textTheme.titleLarge?.copyWith(
                      fontSize: 14,
                      color: AppColors.mainColorLight,
                    ),
                  ),
                  TextSpan(
                    text: ' )',
                    style: inherit.theme.textTheme.titleLarge?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
            : Text(
              title,
              style: inherit.theme.textTheme.titleLarge?.copyWith(fontSize: 14),
            ),
        const Spacer(),
        isSwitch
            ? switchWidget!
            : GestureDetector(
              onTap: onTrailingTap,
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.mainColorLight,
              ),
            ),
      ],
    );
  }
}
