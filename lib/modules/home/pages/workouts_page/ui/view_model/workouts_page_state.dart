part of 'workouts_page_cubit.dart';

enum WorkoutsPageStatus { initial, loading, success, error }

class WorkoutsPageState extends Equatable {
  final WorkoutsPageStatus getMusclesGroupStatus;
  final WorkoutsPageStatus getMuscleGroupWorkoutsStatus;
  final List<MuscleGroupEntity>? musclesGroup;
  final List<MuscleEntity>? muscleGroupWorkouts;
  final Object? getMusclesGroupError;
  final Object? getMuscleGroupWorkoutsError;

  const WorkoutsPageState({
    this.getMusclesGroupStatus = WorkoutsPageStatus.initial,
    this.getMuscleGroupWorkoutsStatus = WorkoutsPageStatus.initial,
    this.musclesGroup,
    this.getMusclesGroupError,
    this.getMuscleGroupWorkoutsError,
    this.muscleGroupWorkouts,
  });

  WorkoutsPageState copyWith({
    WorkoutsPageStatus? getMusclesGroupStatus,
    WorkoutsPageStatus? getMuscleGroupWorkoutsStatus,
    List<MuscleGroupEntity>? musclesGroup,
    Object? getMusclesGroupError,
    Object? getMuscleGroupWorkoutsError,
    List<MuscleEntity>? muscleGroupWorkouts,
  }) {
    return WorkoutsPageState(
      getMusclesGroupStatus:
          getMusclesGroupStatus ?? this.getMusclesGroupStatus,
      getMuscleGroupWorkoutsStatus:
          getMuscleGroupWorkoutsStatus ?? this.getMuscleGroupWorkoutsStatus,
      musclesGroup: musclesGroup ?? this.musclesGroup,
      getMusclesGroupError: getMusclesGroupError ?? this.getMusclesGroupError,
      getMuscleGroupWorkoutsError:
          getMuscleGroupWorkoutsError ?? this.getMuscleGroupWorkoutsError,
      muscleGroupWorkouts: muscleGroupWorkouts ?? this.muscleGroupWorkouts,
    );
  }

  @override
  List<Object?> get props => [
    getMusclesGroupStatus,
    musclesGroup,
    getMusclesGroupError,
    getMuscleGroupWorkoutsStatus,
    getMuscleGroupWorkoutsError,
    muscleGroupWorkouts,
  ];
}
