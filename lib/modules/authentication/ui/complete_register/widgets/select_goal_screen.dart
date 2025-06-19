import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';

import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/colors/app_colors.dart';
import '../view_model/complete_register_cubit.dart';

class SelectGoalScreen extends StatefulWidget {
  const SelectGoalScreen({super.key});

  @override
  State<SelectGoalScreen> createState() => _SelectGoalScreenState();
}

class _SelectGoalScreenState extends BaseStatefulWidgetState<SelectGoalScreen> {
  List<String> goals = [
    getIt<AppLocalizations>().gainWeight,
    getIt<AppLocalizations>().loseWeight,
    getIt<AppLocalizations>().getFitter,
    getIt<AppLocalizations>().gainMoreFlexible,
    getIt<AppLocalizations>().learnTheBasic,
  ];


  String? selectedGoal;

  @override
  void initState() {
    super.initState();
    selectedGoal = BlocProvider.of<CompleteRegisterCubit>(context).state.goal;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${appLocalizations.whatIsYourGoal.toUpperCase()}\n",
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: appLocalizations.thisHelpsUsCreateYourPersonalizedPlan,
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
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder:
                        (context, index) => Container(
                          height: screenHeight * 0.05,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 24,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.white),
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.white.withAlpha(30),
                          ),
                          child: Row(
                            children: [
                              Text(
                                goals[index],
                                style: theme.textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Spacer(),
                              Radio<String>(
                                value: goals[index],
                                groupValue: selectedGoal,
                                onChanged: (val) {
                                  setState(() {
                                    selectedGoal = val;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                    itemCount: 5,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  FilledButton(
                    onPressed:
                        selectedGoal == null
                            ? null
                            : () {
                              BlocProvider.of<CompleteRegisterCubit>(
                                context,
                              ).updateStatus(
                                BlocProvider.of<CompleteRegisterCubit>(
                                  context,
                                ).state.status,
                                goal: selectedGoal,
                              );
                            },
                    child: Text(appLocalizations.next),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
