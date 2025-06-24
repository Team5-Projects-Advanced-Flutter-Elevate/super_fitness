import 'package:equatable/equatable.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';

enum Status { idle, loading, success, error }

class HomePageState extends Equatable {
  final Status randomExercisesStatus;
  final RandomExercisesResponseEntity? randomExercisesResponse;
  final List<String>? exercisesVideosThumbnailsUrls;
  final Object? error;

  const HomePageState({
    this.randomExercisesStatus = Status.idle,
    this.randomExercisesResponse,
    this.exercisesVideosThumbnailsUrls,
    this.error,
  });

  @override
  List<Object?> get props => [
    randomExercisesStatus,
    randomExercisesResponse,
    exercisesVideosThumbnailsUrls,
    error,
  ];

  HomePageState copyWith({
    Status? randomExercisesStatus,
    RandomExercisesResponseEntity? randomExercisesResponse,
    List<String>? exercisesVideosThumbnailsUrls,
    Object? error,
  }) {
    return HomePageState(
      randomExercisesStatus:
          randomExercisesStatus ?? this.randomExercisesStatus,
      randomExercisesResponse:
          randomExercisesResponse ?? this.randomExercisesResponse,
      exercisesVideosThumbnailsUrls:
          exercisesVideosThumbnailsUrls ?? this.exercisesVideosThumbnailsUrls,
      error: error ?? this.error,
    );
  }
}
