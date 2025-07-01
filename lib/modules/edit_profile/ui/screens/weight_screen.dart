import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';

class WeightScreen extends StatefulWidget {
  final void Function(int selectedWeight)? onSelected;

  const WeightScreen({super.key, this.onSelected});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends BaseStatefulWidgetState<WeightScreen> {
  int currentValue = 35;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPaths.homeBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
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
        body: Column(
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
                          "${appLocalizations.whatIsYourWeight.toUpperCase()}\n",
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text:
                          appLocalizations
                              .thisHelpsUsCreateYourPersonalizedPlan,
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
                      Center(
                        child: Text(
                          appLocalizations.kg,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppColors.mainColorLight,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          NumberPicker(
                            value: currentValue,
                            minValue: 14,
                            maxValue: 200,
                            itemCount: 5,
                            step: 1,
                            axis: Axis.horizontal,
                            itemHeight: 70,
                            itemWidth: 70,
                            selectedTextStyle: theme.textTheme.titleLarge
                                ?.copyWith(
                                  color: AppColors.mainColorLight,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 33,
                                ),
                            textStyle: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                            onChanged: (int value) {
                              setState(() {
                                currentValue = value;
                              });
                            },
                          ),
                          Positioned(
                            top: 50,
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: AppColors.mainColorLight,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      FilledButton(
                        onPressed: () {
                          widget.onSelected?.call(currentValue);
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
    );
  }
}
