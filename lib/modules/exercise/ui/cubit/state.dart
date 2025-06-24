import 'package:equatable/equatable.dart';
import '../../domain/entity/get_exercise.dart';

enum Status { idle, loading, success, error }

class ExerciseState extends Equatable {
  final Status status;
  final Status thumbnailStatus;
  final List<String> thumbnailUrl;
  final List<ExerciseEntity> exercises;
  final String? selectedThumbnailUrl;
  final String?selectedShortLink;
  final String? selectedLevelId;
  final Object? error;

  const ExerciseState({
    this.status = Status.idle,
    this.thumbnailStatus = Status.idle,
    this.thumbnailUrl = const [],
    this.exercises = const [],
    this.selectedThumbnailUrl='',
    this.selectedShortLink='',
    this.selectedLevelId='',
    this.error,
  });

  ExerciseState copyWith({
    Status? status,
    Status? thumbnailStatus,
    List<String>? thumbnailUrl,
    List<ExerciseEntity>? exercises,
    String? selectedThumbnailUrl,
    String?selectedShortLink,
    String?selectedLevelId,
    Object? error,
  }) {
    return ExerciseState(
      status: status ?? this.status,
      thumbnailStatus: thumbnailStatus ?? this.thumbnailStatus,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      exercises: exercises ?? this.exercises,
      selectedThumbnailUrl: selectedThumbnailUrl ?? this.selectedThumbnailUrl,
      selectedShortLink: selectedShortLink??this.selectedShortLink,
      selectedLevelId:  selectedLevelId??this.selectedLevelId,
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
    selectedThumbnailUrl,
    selectedLevelId,
    selectedShortLink
  ];
}
