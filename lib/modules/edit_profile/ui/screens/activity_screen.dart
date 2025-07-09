import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../shared_layers/localization/generated/app_localizations.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';

class ActivityScreen extends StatefulWidget {
  final void Function(String selectedActivity)? onSelected;

  const ActivityScreen({super.key, this.onSelected});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends BaseStatefulWidgetState<ActivityScreen> {
  late List<String> activities;
  String? selectedActivity;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    activities = [
      getIt<AppLocalizations>().rookie,
      getIt<AppLocalizations>().beginner,
      getIt<AppLocalizations>().intermediate,
      getIt<AppLocalizations>().advanced,
      getIt<AppLocalizations>().trueBeast,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPaths.homeBg),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            forceMaterialTransparency: true,
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            title: Image.asset(
              AssetsPaths.fitnessAppIcon,
              width: screenWidth * 0.2,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.08),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "${appLocalizations.yourPhysicalActivityLevel.toUpperCase()} \n",
                          style: theme.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: appLocalizations.activityLevel,
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                    child: Container(
                      width: screenWidth,
                      color: AppColors.black.withAlpha(30),
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: activities.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: screenHeight * 0.05,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 24,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.white),
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.white.withAlpha(30),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      activities[index],
                                      style: theme.textTheme.labelMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const Spacer(),
                                    Radio<String>(
                                      value: activities[index],
                                      groupValue: selectedActivity,
                                      onChanged: (val) {
                                        setState(() {
                                          selectedActivity = val;
                                          selectedIndex = index;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          FilledButton(
                            onPressed:
                                selectedActivity == null
                                    ? null
                                    : () {
                                      // call callback if provided
                                      widget.onSelected?.call(
                                        selectedActivity!,
                                      );
                                      Navigator.pop(context);
                                    },
                            child: Text(appLocalizations.done),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
