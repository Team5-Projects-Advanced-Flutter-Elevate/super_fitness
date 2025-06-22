import 'package:equatable/equatable.dart';
import '../../domain/entity/get_exercise.dart';

enum Status { idle, loading, success, error }

class ExerciseState extends Equatable {
  final Status status;
  final Status thumbnailStatus;
  final List<String> thumbnailUrl;
  final List<ExerciseEntity> exercises;
  final String? selectedThumbnailUrl;
  final Object? error;

  const ExerciseState({
    this.status = Status.idle,
    this.thumbnailStatus = Status.idle,
    this.thumbnailUrl = const [],
    this.exercises = const [],
    this.selectedThumbnailUrl='',
    this.error,
  });

  ExerciseState copyWith({
    Status? status,
    Status? thumbnailStatus,
    List<String>? thumbnailUrl,
    List<ExerciseEntity>? exercises,
    String? selectedThumbnailUrl,
    Object? error,
  }) {
    return ExerciseState(
      status: status ?? this.status,
      thumbnailStatus: thumbnailStatus ?? this.thumbnailStatus,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      exercises: exercises ?? this.exercises,
      selectedThumbnailUrl: selectedThumbnailUrl ?? this.selectedThumbnailUrl,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    exercises,
    error,
    thumbnailUrl,
    thumbnailStatus,
    selectedThumbnailUrl
  ];
}
