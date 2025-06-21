import '../../domain/entity/exercise_entity.dart';
import '../../domain/entity/get_exercise.dart';

class GetExerciseModel {
  GetExerciseModel({
    required this.message,
    required this.totalExercises,
    required this.totalPages,
    required this.currentPage,
    required this.exercises,
  });

  final String? message;
  final num? totalExercises;
  final num? totalPages;
  final num? currentPage;
  final List<Exercise> exercises;

  factory GetExerciseModel.fromJson(Map<String, dynamic> json) {
    return GetExerciseModel(
      message: json["message"],
      totalExercises: json["totalExercises"],
      totalPages: json["totalPages"],
      currentPage: json["currentPage"],
      exercises:
          json["exercises"] == null
              ? []
              : List<Exercise>.from(
                json["exercises"]!.map((x) => Exercise.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "totalExercises": totalExercises,
    "totalPages": totalPages,
    "currentPage": currentPage,
    "exercises": exercises.map((x) => x.toJson()).toList(),
  };

  GetExerciseEntity toEntity() => GetExerciseEntity(
    exercises: exercises.map((e) => e.toEntity()).toList(),
    message: message,
    currentPage: currentPage,
    totalExercises: totalExercises,
    totalPages: totalPages
  );


}

class Exercise {
  Exercise({
    required this.id,
    required this.exercise,
    required this.shortYoutubeDemonstration,
    required this.inDepthYoutubeExplanation,
    required this.difficultyLevel,
    required this.targetMuscleGroup,
    required this.primeMoverMuscle,
    required this.secondaryMuscle,
    required this.tertiaryMuscle,
    required this.primaryEquipment,
    required this.primaryItems,
    required this.secondaryEquipment,
    required this.secondaryItems,
    required this.posture,
    required this.singleOrDoubleArm,
    required this.continuousOrAlternatingArms,
    required this.grip,
    required this.loadPositionEnding,
    required this.continuousOrAlternatingLegs,
    required this.footElevation,
    required this.combinationExercises,
    required this.movementPattern1,
    required this.movementPattern2,
    required this.movementPattern3,
    required this.planeOfMotion1,
    required this.planeOfMotion2,
    required this.planeOfMotion3,
    required this.bodyRegion,
    required this.forceType,
    required this.mechanics,
    required this.laterality,
    required this.primaryExerciseClassification,
    required this.shortYoutubeDemonstrationLink,
    required this.inDepthYoutubeExplanationLink,
  });

  final String? id;
  final String? exercise;
  final String? shortYoutubeDemonstration;
  final String? inDepthYoutubeExplanation;
  final String? difficultyLevel;
  final String? targetMuscleGroup;
  final String? primeMoverMuscle;
  final dynamic secondaryMuscle;
  final dynamic tertiaryMuscle;
  final String? primaryEquipment;
  final num? primaryItems;
  final dynamic secondaryEquipment;
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
  final String? movementPattern2;
  final dynamic movementPattern3;
  final String? planeOfMotion1;
  final String? planeOfMotion2;
  final dynamic planeOfMotion3;
  final String? bodyRegion;
  final String? forceType;
  final String? mechanics;
  final String? laterality;
  final String? primaryExerciseClassification;
  final String? shortYoutubeDemonstrationLink;
  final String? inDepthYoutubeExplanationLink;

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json["_id"],
      exercise: json["exercise"],
      shortYoutubeDemonstration: json["short_youtube_demonstration"],
      inDepthYoutubeExplanation: json["in_depth_youtube_explanation"],
      difficultyLevel: json["difficulty_level"],
      targetMuscleGroup: json["target_muscle_group"],
      primeMoverMuscle: json["prime_mover_muscle"],
      secondaryMuscle: json["secondary_muscle"],
      tertiaryMuscle: json["tertiary_muscle"],
      primaryEquipment: json["primary_equipment"],
      primaryItems: json["_primary_items"],
      secondaryEquipment: json["secondary_equipment"],
      secondaryItems: json["_secondary_items"],
      posture: json["posture"],
      singleOrDoubleArm: json["single_or_double_arm"],
      continuousOrAlternatingArms: json["continuous_or_alternating_arms"],
      grip: json["grip"],
      loadPositionEnding: json["load_position_ending"],
      continuousOrAlternatingLegs: json["continuous_or_alternating_legs"],
      footElevation: json["foot_elevation"],
      combinationExercises: json["combination_exercises"],
      movementPattern1: json["movement_pattern_1"],
      movementPattern2: json["movement_pattern_2"],
      movementPattern3: json["movement_pattern_3"],
      planeOfMotion1: json["plane_of_motion_1"],
      planeOfMotion2: json["plane_of_motion_2"],
      planeOfMotion3: json["plane_of_motion_3"],
      bodyRegion: json["body_region"],
      forceType: json["force_type"],
      mechanics: json["mechanics"],
      laterality: json["laterality"],
      primaryExerciseClassification: json["primary_exercise_classification"],
      shortYoutubeDemonstrationLink: json["short_youtube_demonstration_link"],
      inDepthYoutubeExplanationLink: json["in_depth_youtube_explanation_link"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "exercise": exercise,
    "short_youtube_demonstration": shortYoutubeDemonstration,
    "in_depth_youtube_explanation": inDepthYoutubeExplanation,
    "difficulty_level": difficultyLevel,
    "target_muscle_group": targetMuscleGroup,
    "prime_mover_muscle": primeMoverMuscle,
    "secondary_muscle": secondaryMuscle,
    "tertiary_muscle": tertiaryMuscle,
    "primary_equipment": primaryEquipment,
    "_primary_items": primaryItems,
    "secondary_equipment": secondaryEquipment,
    "_secondary_items": secondaryItems,
    "posture": posture,
    "single_or_double_arm": singleOrDoubleArm,
    "continuous_or_alternating_arms": continuousOrAlternatingArms,
    "grip": grip,
    "load_position_ending": loadPositionEnding,
    "continuous_or_alternating_legs": continuousOrAlternatingLegs,
    "foot_elevation": footElevation,
    "combination_exercises": combinationExercises,
    "movement_pattern_1": movementPattern1,
    "movement_pattern_2": movementPattern2,
    "movement_pattern_3": movementPattern3,
    "plane_of_motion_1": planeOfMotion1,
    "plane_of_motion_2": planeOfMotion2,
    "plane_of_motion_3": planeOfMotion3,
    "body_region": bodyRegion,
    "force_type": forceType,
    "mechanics": mechanics,
    "laterality": laterality,
    "primary_exercise_classification": primaryExerciseClassification,
    "short_youtube_demonstration_link": shortYoutubeDemonstrationLink,
    "in_depth_youtube_explanation_link": inDepthYoutubeExplanationLink,
  };

  ExerciseEntity toEntity() => ExerciseEntity(
    id: id,
    exercise: exercise,
    difficultyLevel: difficultyLevel,
    targetMuscleGroup: targetMuscleGroup,
    primaryEquipment: primaryEquipment,
    primaryItems: primaryItems,
    posture: posture,
    shortYoutubeDemonstrationLink: shortYoutubeDemonstrationLink,
    inDepthYoutubeExplanationLink: inDepthYoutubeExplanationLink,
  );
}
