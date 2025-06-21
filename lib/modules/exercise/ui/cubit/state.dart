import 'package:equatable/equatable.dart';
import '../../domain/entity/get_exercise.dart';

enum Status { idle, loading, success, error }

class ExerciseState extends Equatable {
  final Status status;
  final List<ExerciseEntity> exercises;
  final Object? error;

  const ExerciseState({
    this.status = Status.idle,
    this.exercises = const [],
    this.error,
  });

  ExerciseState copyWith({
    Status? status,
    List<ExerciseEntity>? exercises,
    Object? error,
  }) {
    return ExerciseState(
      status: status ?? this.status,
      exercises: exercises ?? this.exercises,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, exercises, error];
}
