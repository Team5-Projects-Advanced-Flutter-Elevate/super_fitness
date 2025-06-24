import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_request_entity.dart';

/// targetMuscleGroupId : "67c79f3526895f87ce0aa96d"
/// difficultyLevelId : "67c79f3526895f87ce0aa96d"
/// limit : 10
class RandomExercisesRequestDto {
  RandomExercisesRequestDto({
    this.targetMuscleGroupId,
    this.difficultyLevelId,
    this.limit,
  });

  RandomExercisesRequestDto.fromJson(dynamic json) {
    targetMuscleGroupId = json['targetMuscleGroupId'];
    difficultyLevelId = json['difficultyLevelId'];
    limit = json['limit'];
  }

  late final String? targetMuscleGroupId;
  late final String? difficultyLevelId;
  late final num? limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['targetMuscleGroupId'] = targetMuscleGroupId;
    map['difficultyLevelId'] = difficultyLevelId;
    map['limit'] = limit;
    return map;
  }

  static RandomExercisesRequestDto convertIntoDto(
    RandomExercisesRequestEntity entity,
  ) {
    return RandomExercisesRequestDto(
      targetMuscleGroupId: entity.targetMuscleGroupId,
      difficultyLevelId: entity.difficultyLevelId,
      limit: entity.limit,
    );
  }
}
