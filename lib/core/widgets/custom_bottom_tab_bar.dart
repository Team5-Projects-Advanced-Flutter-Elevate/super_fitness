import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';

class CustomBottomTabBar extends BaseStatelessWidget
    implements PreferredSizeWidget {
  final List<Widget> tabs;
  final bool isScrollable;

  /// This height only get applied if the TabBar is given to 'bottom' parameter of AppBar() widget
  final double preferredHeight;

  final double horizontalPaddingWhenScrollable;
  final double? horizontalLabelPadding;

  final void Function(int index)? onTabClick;

  const CustomBottomTabBar({
    super.key,
    required this.tabs,
    this.isScrollable = false,
    this.onTabClick,
    this.preferredHeight = 70,
    this.horizontalPaddingWhenScrollable = 8,
    this.horizontalLabelPadding,
  });

  @override
  Widget customBuild(BuildContext context, inherit) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isScrollable ? horizontalPaddingWhenScrollable : 0,
      ),
      child: TabBar(
        tabs: tabs,
        isScrollable: isScrollable,
        tabAlignment: isScrollable ? TabAlignment.start : null,
        labelPadding:
            horizontalLabelPadding == null
                ? null
                : EdgeInsets.symmetric(horizontal: horizontalLabelPadding!),
        indicatorPadding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: -8,
        ),
        onTap: onTabClick,
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, preferredHeight);
}
