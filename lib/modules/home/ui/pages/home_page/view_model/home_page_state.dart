import 'package:equatable/equatable.dart';
import 'package:super_fitness/modules/food/domain/entities/food_categories_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscle_group_workout_response_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscles_group_response_entity.dart';

enum Status { idle, loading, success, error }

class HomePageState extends Equatable {
  final Status randomExercisesStatus;
  final Status foodCategoriesStatus;
  final Status musclesGroupsStatus;
  final Status muscleWorkoutsStatus;
  final RandomExercisesResponseEntity? randomExercisesResponse;
  final List<String>? exercisesVideosThumbnailsUrls;
  final List<FoodCategoryEntity>? foodCategoryEntities;
  final List<MuscleGroupEntity>? musclesGroups;
  final List<MuscleEntity>? muscles;
  final Object? randomExercisesError;
  final Object? foodCategoriesError;
  final Object? musclesGroupsError;
  final Object? muscleWorkoutsError;

  const HomePageState({
    this.randomExercisesStatus = Status.idle,
    this.foodCategoriesStatus = Status.idle,
    this.musclesGroupsStatus = Status.idle,
    this.muscleWorkoutsStatus = Status.idle,
    this.randomExercisesResponse,
    this.exercisesVideosThumbnailsUrls,
    this.foodCategoryEntities,
    this.musclesGroups,
    this.muscles,
    this.randomExercisesError,
    this.foodCategoriesError,
    this.musclesGroupsError,
    this.muscleWorkoutsError,
  });

  @override
  List<Object?> get props => [
    randomExercisesStatus,
    foodCategoriesStatus,
    musclesGroupsStatus,
    muscleWorkoutsStatus,
    randomExercisesResponse,
    exercisesVideosThumbnailsUrls,
    foodCategoryEntities,
    musclesGroups,
    muscles,
    randomExercisesError,
    foodCategoriesError,
    musclesGroupsError,
    muscleWorkoutsError,
  ];

  HomePageState copyWith({
    Status? randomExercisesStatus,
    Status? foodCategoriesStatus,
    Status? musclesGroupsStatus,
    Status? muscleWorkoutsStatus,
    RandomExercisesResponseEntity? randomExercisesResponse,
    List<String>? exercisesVideosThumbnailsUrls,
    List<FoodCategoryEntity>? foodCategoryEntities,
    List<MuscleGroupEntity>? musclesGroups,
    List<MuscleEntity>? muscles,
    Object? randomExercisesError,
    Object? foodCategoriesError,
    Object? musclesGroupsError,
    Object? muscleWorkoutsError,
  }) {
    return HomePageState(
      randomExercisesStatus:
          randomExercisesStatus ?? this.randomExercisesStatus,
      foodCategoriesStatus: foodCategoriesStatus ?? this.foodCategoriesStatus,
      musclesGroupsStatus: musclesGroupsStatus ?? this.musclesGroupsStatus,
      muscleWorkoutsStatus: muscleWorkoutsStatus ?? this.muscleWorkoutsStatus,
      randomExercisesResponse:
          randomExercisesResponse ?? this.randomExercisesResponse,
      exercisesVideosThumbnailsUrls:
          exercisesVideosThumbnailsUrls ?? this.exercisesVideosThumbnailsUrls,
      foodCategoryEntities: foodCategoryEntities ?? this.foodCategoryEntities,
      musclesGroups: musclesGroups ?? this.musclesGroups,
      muscles: muscles ?? this.muscles,
      randomExercisesError: randomExercisesError ?? this.randomExercisesError,
      foodCategoriesError: foodCategoriesError ?? this.foodCategoriesError,
      musclesGroupsError: musclesGroupsError ?? this.musclesGroupsError,
      muscleWorkoutsError: muscleWorkoutsError ?? this.muscleWorkoutsError,
    );
  }
}
