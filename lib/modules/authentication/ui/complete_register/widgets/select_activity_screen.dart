import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/utilities/extensions/gender_ex.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/authentication/ui/register/view_model/register_state.dart';
import 'package:super_fitness/modules/authentication/ui/register/view_model/register_view_model.dart';
import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../shared_layers/localization/generated/app_localizations.dart';
import '../view_model/complete_register_cubit.dart';

class SelectedActivityScreen extends StatefulWidget {
  const SelectedActivityScreen({super.key});

  @override
  State<SelectedActivityScreen> createState() => _SelectedActivityScreenState();
}

class _SelectedActivityScreenState
    extends BaseStatefulWidgetState<SelectedActivityScreen> {
  List<String> goals = [
    getIt<AppLocalizations>().rookie,
    getIt<AppLocalizations>().beginner,
    getIt<AppLocalizations>().intermediate,
    getIt<AppLocalizations>().advanced,
    getIt<AppLocalizations>().trueBeast,
  ];

  String? selectedActivity;

  late CompleteRegisterCubit cubit;

  @override
  void initState() {
    super.initState();
    selectedActivity =
        BlocProvider.of<CompleteRegisterCubit>(context).state.activity;
  }

  @override
  Widget build(BuildContext context) {
    cubit = BlocProvider.of<CompleteRegisterCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${appLocalizations.yourPhysicalActivityLevel.toUpperCase()} \n",
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
                                activities[index],
                                style: theme.textTheme.labelMedium?.copyWith(
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
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                    itemCount: 5,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  BlocBuilder<RegisterViewModel, RegisterState>(
                    builder: (context, state) {
                      return FilledButton(
                        onPressed:
                            selectedActivity == null
                                ? null
                                : () {
                                  cubit.updateStatus(
                                    cubit.state.status,
                                    activity: selectedActivity,
                                  );

                                  log(cubit.state.toString());

                                  BlocProvider.of<RegisterViewModel>(
                                    context,
                                  ).doIntent(
                                    RegisterUser(
                                      restOfRegisterRequest:
                                          RestOfRegisterRequest(
                                            gender:
                                                cubit.state.isMale!
                                                    ? Gender.male.getValue()
                                                    : Gender.female.getValue(),
                                            age: cubit.state.age,
                                            weight: cubit.state.weight,
                                            height: cubit.state.height,
                                            goal: cubit.state.goal!,
                                            activityLevel:
                                                cubit.state.activity!,
                                          ),
                                    ),
                                  );
                                },
                        child:
                            state.registerStatus == Status.loading
                                ? LoadingStateWidget(
                                  progressIndicatorColor: AppColors.white,
                                )
                                : const Text(appLocalizations.next),
                      );
                    },
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
