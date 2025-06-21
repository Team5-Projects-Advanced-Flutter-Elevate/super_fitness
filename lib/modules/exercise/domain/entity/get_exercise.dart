class ExerciseEntity {
  final String? id;
  final String? exercise;
  final String? difficultyLevel;
  final String? targetMuscleGroup;
  final String? primaryEquipment;
  final num? primaryItems;
  final String? posture;
  final String? shortYoutubeDemonstrationLink;
  final String? inDepthYoutubeExplanationLink;

  const ExerciseEntity({
    this.id,
    this.exercise,
    this.difficultyLevel,
    this.targetMuscleGroup,
    this.primaryEquipment,
    this.primaryItems,
    this.posture,
    this.shortYoutubeDemonstrationLink,
    this.inDepthYoutubeExplanationLink,
  });
}
