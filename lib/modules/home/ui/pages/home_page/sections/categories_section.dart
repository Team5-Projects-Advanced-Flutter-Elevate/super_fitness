import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/core/utilities/mixins/widget_height_watcher.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/widgets/category_item.dart';
import 'package:super_fitness/modules/home/ui/view_model/home_view_model.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends BaseStatefulWidgetState<CategoriesSection>
    with WidgetHeightWatcher<CategoriesSection> {
  final GlobalKey categoryItemKey = GlobalKey();
  double categoryItemHeight = 0;

  late HomeViewModel homeViewModel;

  @override
  void initState() {
    super.initState();
    // Wait until the first frame is rendered
    waitForStableHeight(
      key: categoryItemKey,
      onHeightReady: (height) {
        setState(() {
          categoryItemHeight = height;
        });
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeViewModel = Provider.of<HomeViewModel>(context);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.category,
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
                  key: categoryItemKey,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DefinedRoutes.upcomingFeatureScreen,
                    );
                  },
                  image: AssetsPaths.gymPersonIcon,
                  title: appLocalizations.gym,
                ),
              ),
              SizedBox(
                height: categoryItemHeight,
                child: VerticalDivider(
                  color: AppColors.black[70],
                  indent: 6,
                  endIndent: 6,
                ),
              ),
              Expanded(
                child: CategoryItem(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DefinedRoutes.upcomingFeatureScreen,
                    );
                  },
                  image: AssetsPaths.fitnessPersonIcon,
                  title: appLocalizations.fitness,
                ),
              ),
              SizedBox(
                height: categoryItemHeight,
                child: VerticalDivider(
                  color: AppColors.black[70],
                  indent: 6,
                  endIndent: 6,
                ),
              ),
              Expanded(
                child: CategoryItem(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DefinedRoutes.upcomingFeatureScreen,
                    );
                  },
                  image: AssetsPaths.yogaPersonIcon,
                  title: appLocalizations.yoga,
                ),
              ),
              SizedBox(
                height: categoryItemHeight,
                child: VerticalDivider(
                  color: AppColors.black[70],
                  indent: 6,
                  endIndent: 6,
                ),
              ),
              Expanded(
                child: CategoryItem(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DefinedRoutes.upcomingFeatureScreen,
                    );
                  },
                  image: AssetsPaths.aerobicsPersonIcon,
                  title: appLocalizations.aerobics,
                ),
              ),
              SizedBox(
                height: categoryItemHeight,
                child: VerticalDivider(
                  color: AppColors.black[70],
                  indent: 6,
                  endIndent: 6,
                ),
              ),
              Expanded(
                child: CategoryItem(
                  onTap: () {
                    homeViewModel.navigateToPage(1);
                  },
                  image: AssetsPaths.trainerPersonIcon,
                  title: appLocalizations.trainer,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
