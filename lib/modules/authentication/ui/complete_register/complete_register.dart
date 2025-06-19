import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:super_fitness/core/apis/api_error/api_error_handler.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/view_model/complete_register_cubit.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/widgets/select_activity_screen.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/widgets/select_age_screen.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/widgets/select_gender_screen.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/widgets/select_goal_screen.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/widgets/select_height_screen.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/widgets/select_weight_screen.dart';
import 'package:super_fitness/modules/authentication/ui/register/view_model/register_state.dart';
import 'package:super_fitness/modules/authentication/ui/register/view_model/register_view_model.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';

class CompleteRegister extends StatefulWidget {
  const CompleteRegister({super.key});

  @override
  State<CompleteRegister> createState() => _CompleteRegisterState();
}

class _CompleteRegisterState extends BaseStatefulWidgetState<CompleteRegister> {
  late RegisterViewModel registerViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    registerViewModel = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPaths.authBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                pageViewController: registerViewModel.pageViewController,
              );
            },
            icon: const ImageIcon(AssetImage(AssetsPaths.backIcon)),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: BlocListener<RegisterViewModel, RegisterState>(
            listener: (context, state) {
              switch (state.registerStatus) {
                case Status.idle:
                case Status.loading:
                  break;

                case Status.success:
                  displaySnackBar(
                    contentType: ContentType.success,
                    title: "Registered Successfully!",
                  );
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    DefinedRoutes.loginScreenRoute,
                    (route) => false,
                  );
                  break;

                case Status.error:
                  displaySnackBar(
                    contentType: ContentType.failure,
                    title: "Error!",
                    message: getIt.get<ApiErrorHandler>().handle(state.error!),
                    durationInSeconds: 4,
                  );
                  break;
              }
            },
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
