import 'package:equatable/equatable.dart';

class RandomExercisesResponseEntity extends Equatable {
  const RandomExercisesResponseEntity({
    this.message,
    this.totalExercises,
    this.exercises,
  });

  final String? message;
  final num? totalExercises;
  final List<ExerciseEntity>? exercises;

  @override
  List<Object?> get props => [message, totalExercises, exercises];
}

class ExerciseEntity extends Equatable {
  const ExerciseEntity({
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

  final String? id;
  final String? exercise;
  final String? shortYoutubeDemonstration;
  final String? inDepthYoutubeExplanation;
  final String? difficultyLevel;
  final String? targetMuscleGroup;
  final String? primeMoverMuscle;
  final String? primaryEquipment;
  final num? primaryItems;
  final num? secondaryItems;
  final String? posture;
  final String? singleOrDoubleArm;
  final String? continuousOrAlternatingArms;
  final String? grip;
  final String? loadPositionEnding;
  final String? continuousOrAlternatingLegs;
  final String? footElevation;
  final String? combinationExercises;
  final String? movementPattern1;
  final String? planeOfMotion1;
  final String? bodyRegion;
  final String? forceType;
  final String? mechanics;
  final String? laterality;
  final String? primaryExerciseClassification;
  final String? shortYoutubeDemonstrationLink;
  final String? inDepthYoutubeExplanationLink;

  @override
  List<Object?> get props => [
    id,
    exercise,
    shortYoutubeDemonstration,
    inDepthYoutubeExplanation,
    difficultyLevel,
    targetMuscleGroup,
    primeMoverMuscle,
    primaryEquipment,
    primaryItems,
    secondaryItems,
    posture,
    singleOrDoubleArm,
    continuousOrAlternatingArms,
    grip,
    loadPositionEnding,
    continuousOrAlternatingLegs,
    footElevation,
    combinationExercises,
    movementPattern1,
    planeOfMotion1,
    bodyRegion,
    forceType,
    mechanics,
    laterality,
    primaryExerciseClassification,
    shortYoutubeDemonstrationLink,
    inDepthYoutubeExplanationLink,
  ];
}
