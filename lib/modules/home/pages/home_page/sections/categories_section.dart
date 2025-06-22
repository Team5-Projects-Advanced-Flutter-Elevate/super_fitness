import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/modules/home/pages/home_page/widgets/category_item.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState
    extends BaseStatefulWidgetState<CategoriesSection> {
  final GlobalKey _widgetAKey = GlobalKey();
  double _widgetAHeight = 0;

  @override
  void initState() {
    super.initState();
    // Wait until the first frame is rendered
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      final RenderBox renderBox =
          _widgetAKey.currentContext?.findRenderObject() as RenderBox;
      if (renderBox != null) {
        setState(() {
          _widgetAHeight = renderBox.size.height;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Category",
          style: theme.textTheme.titleMedium!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.black.withAlpha(220),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Row(
            children: [
              Expanded(
                child: CategoryItem(
                  key: _widgetAKey,
                  onTap: () {},
                  image: AssetsPaths.gymPersonIcon,
                  title: "Gym",
                ),
              ),
              SizedBox(
                height: _widgetAHeight,
                child: VerticalDivider(
                  color: AppColors.black[70],
                  indent: 6,
                  endIndent: 6,
                ),
              ),
              Expanded(
                child: CategoryItem(
                  onTap: () {},
                  image: AssetsPaths.fitnessPersonIcon,
                  title: "Fitness",
                ),
              ),
              VerticalDivider(
                color: AppColors.black[70],
                indent: 6,
                endIndent: 6,
              ),
              Expanded(
                child: CategoryItem(
                  onTap: () {},
                  image: AssetsPaths.yogaPersonIcon,
                  title: "Yoga",
                ),
              ),
              VerticalDivider(
                color: AppColors.black[70],
                indent: 6,
                endIndent: 6,
              ),
              Expanded(
                child: CategoryItem(
                  onTap: () {},
                  image: AssetsPaths.aerobicsPersonIcon,
                  title: "Aerobics",
                ),
              ),
              VerticalDivider(
                color: AppColors.black[70],
                indent: 6,
                endIndent: 6,
              ),
              Expanded(
                child: CategoryItem(
                  onTap: () {},
                  image: AssetsPaths.trainerPersonIcon,
                  title: "Trainer",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
