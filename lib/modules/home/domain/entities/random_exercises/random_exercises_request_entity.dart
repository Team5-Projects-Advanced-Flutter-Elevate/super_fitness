class RandomExercisesRequestEntity {
  RandomExercisesRequestEntity({
    this.targetMuscleGroupId,
    this.difficultyLevelId,
    this.limit,
  });

  late final String? targetMuscleGroupId;
  late final String? difficultyLevelId;
  late final num? limit;
}
