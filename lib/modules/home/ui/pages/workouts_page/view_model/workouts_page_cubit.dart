import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscle_group_workout_response_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscles_group_response_entity.dart';
import 'package:super_fitness/modules/home/domain/use_cases/workouts/get_muscle_group_workout_use_case.dart';
import 'package:super_fitness/modules/home/domain/use_cases/workouts/get_muscles_group_use_case.dart';

part 'workouts_page_state.dart';

@injectable
class WorkoutsPageCubit extends Cubit<WorkoutsPageState> {
  WorkoutsPageCubit(
    this._getMusclesGroupUseCase,
    this._getMuscleGroupWorkoutUseCase,
  ) : super(const WorkoutsPageState());

  final GetMusclesGroupUseCase _getMusclesGroupUseCase;
  final GetMuscleGroupWorkoutUseCase _getMuscleGroupWorkoutUseCase;

  void doIntent(WorkoutsPageIntent intent) {
    switch (intent) {
      case GetMusclesGroupIntent():
        _getMusclesGroup();
      case GetMuscleGroupWorkoutsIntent():
        _getMuscleGroupWorkouts(intent.id);
    }
  }

  void _getMusclesGroup() async {
    emit(state.copyWith(getMusclesGroupStatus: WorkoutsPageStatus.loading));
    var result = await _getMusclesGroupUseCase.execute();
    switch (result) {
      case Success<List<MuscleGroupEntity>?>():
        emit(
          state.copyWith(
            getMusclesGroupStatus: WorkoutsPageStatus.success,
            musclesGroup: result.data,
          ),
        );
      case Error<List<MuscleGroupEntity>?>():
        emit(
          state.copyWith(
            getMusclesGroupStatus: WorkoutsPageStatus.error,
            getMusclesGroupError: result.error,
          ),
        );
    }
  }

  void _getMuscleGroupWorkouts(String id) async {
    emit(
      state.copyWith(getMuscleGroupWorkoutsStatus: WorkoutsPageStatus.loading),
    );
    var result = await _getMuscleGroupWorkoutUseCase.execute(id);
    switch (result) {
      case Success<List<MuscleEntity>?>():
        emit(
          state.copyWith(
            getMuscleGroupWorkoutsStatus: WorkoutsPageStatus.success,
            muscleGroupWorkouts: result.data,
          ),
        );
      case Error<List<MuscleEntity>?>():
        emit(
          state.copyWith(
            getMuscleGroupWorkoutsStatus: WorkoutsPageStatus.error,
            getMuscleGroupWorkoutsError: result.error,
          ),
        );
    }
  }
}

sealed class WorkoutsPageIntent {}

class GetMusclesGroupIntent extends WorkoutsPageIntent {}

class GetMuscleGroupWorkoutsIntent extends WorkoutsPageIntent {
  final String id;

  GetMuscleGroupWorkoutsIntent({required this.id});
}
