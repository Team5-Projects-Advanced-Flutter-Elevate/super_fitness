import 'package:equatable/equatable.dart';

class RandomExercisesRequestEntity extends Equatable {
  const RandomExercisesRequestEntity({
    this.targetMuscleGroupId,
    this.difficultyLevelId,
    this.limit,
  });

  final String? targetMuscleGroupId;
  final String? difficultyLevelId;
  final num? limit;

  @override
  List<Object?> get props =>
      [
        targetMuscleGroupId,
        difficultyLevelId,
        limit,
      ];
}

