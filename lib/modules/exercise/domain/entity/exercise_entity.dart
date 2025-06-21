import 'get_exercise.dart';

class GetExerciseEntity {
  final String? message;
  final num? totalExercises;
  final num? totalPages;
  final num? currentPage;
  final List<ExerciseEntity> exercises;

  const GetExerciseEntity({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    required this.exercises,
  });
}
