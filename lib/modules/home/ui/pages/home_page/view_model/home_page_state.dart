import 'package:equatable/equatable.dart';
import 'package:super_fitness/modules/food/domain/entities/food_categories_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';

enum Status { idle, loading, success, error }

class HomePageState extends Equatable {
  final Status randomExercisesStatus;
  final Status foodCategoriesStatus;
  final RandomExercisesResponseEntity? randomExercisesResponse;
  final List<String>? exercisesVideosThumbnailsUrls;
  final List<FoodCategoryEntity>? foodCategoryEntities;
  final Object? randomExercisesError;
  final Object? foodCategoriesError;

  const HomePageState({
    this.randomExercisesStatus = Status.idle,
    this.foodCategoriesStatus = Status.idle,
    this.randomExercisesResponse,
    this.exercisesVideosThumbnailsUrls,
    this.foodCategoryEntities,
    this.randomExercisesError,
    this.foodCategoriesError,
  });

  @override
  List<Object?> get props => [
    randomExercisesStatus,
    foodCategoriesStatus,
    randomExercisesResponse,
    exercisesVideosThumbnailsUrls,
    foodCategoryEntities,
    randomExercisesError,
    foodCategoriesError,
  ];

  HomePageState copyWith({
    Status? randomExercisesStatus,
    Status? foodCategoriesStatus,
    RandomExercisesResponseEntity? randomExercisesResponse,
    List<String>? exercisesVideosThumbnailsUrls,
    List<FoodCategoryEntity>? foodCategoryEntities,
    Object? randomExercisesError,
    Object? foodCategoriesError,
  }) {
    return HomePageState(
      randomExercisesStatus:
          randomExercisesStatus ?? this.randomExercisesStatus,
      foodCategoriesStatus: foodCategoriesStatus ?? this.foodCategoriesStatus,
      randomExercisesResponse:
          randomExercisesResponse ?? this.randomExercisesResponse,
      exercisesVideosThumbnailsUrls:
          exercisesVideosThumbnailsUrls ?? this.exercisesVideosThumbnailsUrls,
      foodCategoryEntities: foodCategoryEntities ?? this.foodCategoryEntities,
      randomExercisesError: randomExercisesError ?? this.randomExercisesError,
      foodCategoriesError: foodCategoriesError ?? this.foodCategoriesError,
    );
  }
}
