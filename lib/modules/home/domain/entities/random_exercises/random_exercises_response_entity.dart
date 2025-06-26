class RandomExercisesResponseEntity {
  RandomExercisesResponseEntity({
    this.message,
    this.totalExercises,
    this.exercises,
  });

  late final String? message;
  late final num? totalExercises;
  late final List<ExerciseEntity>? exercises;
}

class ExerciseEntity {
  ExerciseEntity({
    this.id,
    this.exercise,
    this.shortYoutubeDemonstration,
    this.inDepthYoutubeExplanation,
    this.difficultyLevel,
    this.targetMuscleGroup,
    this.primeMoverMuscle,
    this.primaryEquipment,
    this.primaryItems,
    this.secondaryItems,
    this.posture,
    this.singleOrDoubleArm,
    this.continuousOrAlternatingArms,
    this.grip,
    this.loadPositionEnding,
    this.continuousOrAlternatingLegs,
    this.footElevation,
    this.combinationExercises,
    this.movementPattern1,
    this.planeOfMotion1,
    this.bodyRegion,
    this.forceType,
    this.mechanics,
    this.laterality,
    this.primaryExerciseClassification,
    this.shortYoutubeDemonstrationLink,
    this.inDepthYoutubeExplanationLink,
  });

  late final String? id;
  late final String? exercise;
  late final String? shortYoutubeDemonstration;
  late final String? inDepthYoutubeExplanation;
  late final String? difficultyLevel;
  late final String? targetMuscleGroup;
  late final String? primeMoverMuscle;
  late final String? primaryEquipment;
  late final num? primaryItems;
  late final num? secondaryItems;
  late final String? posture;
  late final String? singleOrDoubleArm;
  late final String? continuousOrAlternatingArms;
  late final String? grip;
  late final String? loadPositionEnding;
  late final String? continuousOrAlternatingLegs;
  late final String? footElevation;
  late final String? combinationExercises;
  late final String? movementPattern1;
  late final String? planeOfMotion1;
  late final String? bodyRegion;
  late final String? forceType;
  late final String? mechanics;
  late final String? laterality;
  late final String? primaryExerciseClassification;
  late final String? shortYoutubeDemonstrationLink;
  late final String? inDepthYoutubeExplanationLink;
}
