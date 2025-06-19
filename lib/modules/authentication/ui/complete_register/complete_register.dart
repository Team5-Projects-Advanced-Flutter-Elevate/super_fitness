import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/view_model/complete_register_cubit.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/widgets/select_activity_screen.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/widgets/select_age_screen.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/widgets/select_gender_screen.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/widgets/select_goal_screen.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/widgets/select_height_screen.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/widgets/select_weight_screen.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';

class CompleteRegister extends StatefulWidget {
  const CompleteRegister({super.key});

  @override
  State<CompleteRegister> createState() => _CompleteRegisterState();
}

class _CompleteRegisterState extends BaseStatefulWidgetState<CompleteRegister> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPaths.authBg),
          fit: BoxFit.cover,
        ),
      ),
      child: BlocListener<CompleteRegisterCubit, CompleteRegisterState>(
        listener: (context, state) {
          if (state.navigateToRegister == true) {
            Navigator.pushReplacementNamed(
              context,
              DefinedRoutes.registerScreenRoute,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Image.asset(
              AssetsPaths.fitnessAppIcon,
              width: screenWidth * 0.2,
            ),
            leading: IconButton(
              color: AppColors.white,
              constraints: const BoxConstraints(maxHeight: 25, maxWidth: 25),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.mainColorLight,
              ),
              onPressed: () {
                BlocProvider.of<CompleteRegisterCubit>(context).goBack(
                  BlocProvider.of<CompleteRegisterCubit>(context).state.status,
                );
              },
              icon: const ImageIcon(AssetImage(AssetsPaths.backIcon)),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: BlocBuilder<
                    CompleteRegisterCubit,
                    CompleteRegisterState
                  >(
                    builder: (context, state) {
                      return Center(
                        child: CircularPercentIndicator(
                          radius: 20,
                          percent:
                              (BlocProvider.of<CompleteRegisterCubit>(
                                    context,
                                  ).state.counter /
                                  6),

                          backgroundColor: Colors.transparent,
                          center: Text(
                            "${BlocProvider.of<CompleteRegisterCubit>(context).state.counter}/6",
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 7,
                  child:
                      BlocBuilder<CompleteRegisterCubit, CompleteRegisterState>(
                        builder: (context, state) {
                          switch (state.status) {
                            case CompleteRegisterStatus.selectGender:
                              return const SelectGenderScreen();
                            case CompleteRegisterStatus.selectAage:
                              return const SelectAgeScreen();
                            case CompleteRegisterStatus.selectWeight:
                              return const SelectWeightScreen();
                            case CompleteRegisterStatus.selectHeight:
                              return const SelectHeightScreen();
                            case CompleteRegisterStatus.selectGoal:
                              return const SelectGoalScreen();
                            case CompleteRegisterStatus.selectActivity:
                              return const SelectedActivityScreen();
                          }
                        },
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
