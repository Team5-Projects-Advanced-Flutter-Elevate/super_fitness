import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/widgets/error_state_widget.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/ui/view_model/workouts_page_cubit.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/ui/widgets/build_workout_success.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends BaseStatefulWidgetState<WorkoutsPage> {
  @override
  void initState() {
    workoutsPageCubit.doIntent(GetMusclesGroupIntent());
    super.initState();
  }

  WorkoutsPageCubit workoutsPageCubit = getIt.get<WorkoutsPageCubit>();
  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => workoutsPageCubit,
      child: BlocConsumer<WorkoutsPageCubit, WorkoutsPageState>(
        listener: (context, state) {
          if (state.getMusclesGroupStatus == WorkoutsPageStatus.success &&
              firstTime) {
            workoutsPageCubit.doIntent(
              GetMuscleGroupWorkoutsIntent(
                id: state.musclesGroup![0].id.toString(),
              ),
            );
            firstTime = false;
          }
        },
        builder: (context, state) {
          switch (state.getMusclesGroupStatus) {
            case WorkoutsPageStatus.initial:
            case WorkoutsPageStatus.loading:
              return const LoadingStateWidget();
            case WorkoutsPageStatus.success:
              return BuildWorkoutsSuccessState(state: state);
            case WorkoutsPageStatus.error:
              return ErrorStateWidget(error: state.getMusclesGroupError!);
          }
        },
      ),
    );
  }
}
