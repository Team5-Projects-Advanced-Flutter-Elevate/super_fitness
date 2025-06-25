import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/utilities/single_data_per_application/single_data_per_application_provider.dart';
import 'package:super_fitness/core/utilities/youtube_video_thumbnail/youtube_video_thumbnail.dart';
import 'package:super_fitness/modules/food/domain/entities/food_categories_entity.dart';
import 'package:super_fitness/modules/food/domain/use_cases/get_food_categories_use_case.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscle_group_workout_response_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscles_group_response_entity.dart';
import 'package:super_fitness/modules/home/domain/use_cases/random_exercises/get_ten_random_exerciese_use_case.dart';
import 'package:super_fitness/modules/home/domain/use_cases/workouts/get_muscle_group_workout_use_case.dart';
import 'package:super_fitness/modules/home/domain/use_cases/workouts/get_muscles_group_use_case.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/view_model/home_page_state.dart';

@injectable
class HomePageViewModel extends Cubit<HomePageState> {
  final GetTenRandomExerciseUseCase _getTenRandomExerciseUseCase;
  final GetFoodCategoriesUseCase _getFoodCategoriesUseCase;
  final GetMusclesGroupUseCase _getMusclesGroupUseCase;
  final GetMuscleGroupWorkoutUseCase _getMuscleGroupWorkoutUseCase;

  HomePageViewModel(
    this._getTenRandomExerciseUseCase,
    this._getFoodCategoriesUseCase,
    this._getMusclesGroupUseCase,
    this._getMuscleGroupWorkoutUseCase,
  ) : super(const HomePageState());

  void doIntent(HomePageIntent intent) {
    switch (intent) {
      case LoadHomePage():
        _getRandomExercises();
        _getFoodCategories();
        _getMusclesGroups();
        break;

      case GetMuscleWorkouts():
        _getMusclesWorkouts(intent.musclesGroupId);
    }
  }

  void _getRandomExercises() async {
    emit(const HomePageState(randomExercisesStatus: Status.loading));
    final singleDataProvider = getIt.get<SingleDataPerApplicationProvider>();
    if (singleDataProvider.randomExercisesResponse != null &&
        singleDataProvider.exercisesVideosThumbnailsUrls != null) {
      emit(
        state.copyWith(
          randomExercisesStatus: Status.success,
          randomExercisesResponse: singleDataProvider.randomExercisesResponse,
          exercisesVideosThumbnailsUrls:
              singleDataProvider.exercisesVideosThumbnailsUrls,
        ),
      );
    } else {
      var useCaseResult = await _getTenRandomExerciseUseCase.call();
      switch (useCaseResult) {
        case Success<RandomExercisesResponseEntity>():
          var thumbnailsList = _getVideosThumbnails(
            useCaseResult.data.exercises ?? [],
          );
          singleDataProvider.changeRandomExercisesData(
            entity: useCaseResult.data,
            thumbnailsUrls: thumbnailsList,
          );

          emit(
            state.copyWith(
              randomExercisesStatus: Status.success,
              randomExercisesResponse: useCaseResult.data,
              exercisesVideosThumbnailsUrls: thumbnailsList,
            ),
          );
        case Error<RandomExercisesResponseEntity>():
          emit(
            state.copyWith(
              randomExercisesStatus: Status.error,
              randomExercisesError: useCaseResult.error,
            ),
          );
      }
    }
  }

  List<String> _getVideosThumbnails(List<ExerciseEntity> exercises) {
    List<String> thumbnailsUrls = [];
    for (var exercise in exercises) {
      if (exercise.shortYoutubeDemonstrationLink != null) {
        thumbnailsUrls.add(
          YoutubeVideoThumbnail.getYouTubeThumbnail(
            exercise.shortYoutubeDemonstrationLink!,
          ),
        );
      } else if (exercise.inDepthYoutubeExplanationLink != null) {
        thumbnailsUrls.add(
          YoutubeVideoThumbnail.getYouTubeThumbnail(
            exercise.inDepthYoutubeExplanationLink!,
          ),
        );
      } else {
        thumbnailsUrls.add("");
      }
    }
    return thumbnailsUrls;
  }

  void _getFoodCategories() async {
    emit(
      state.copyWith(
        foodCategoriesStatus: Status.loading,
        foodCategoriesError: null,
      ),
    );
    var useCaseResult = await _getFoodCategoriesUseCase.call();
    switch (useCaseResult) {
      case Success<List<FoodCategoryEntity>>():
        emit(
          state.copyWith(
            foodCategoriesStatus: Status.success,
            foodCategoryEntities: useCaseResult.data,
          ),
        );
      case Error<List<FoodCategoryEntity>>():
        emit(
          state.copyWith(
            foodCategoriesStatus: Status.error,
            foodCategoriesError: state.randomExercisesError,
          ),
        );
    }
  }

  void _getMusclesGroups() async {
    emit(
      state.copyWith(
        musclesGroupsStatus: Status.loading,
        musclesGroupsError: null,
      ),
    );
    var musclesGroupsResult = await _getMusclesGroupUseCase.execute();
    switch (musclesGroupsResult) {
      case Success<List<MuscleGroupEntity>?>():
        emit(
          state.copyWith(
            musclesGroupsStatus: Status.success,
            musclesGroups: musclesGroupsResult.data,
          ),
        );
      case Error<List<MuscleGroupEntity>?>():
        emit(
          state.copyWith(
            musclesGroupsStatus: Status.error,
            musclesGroupsError: musclesGroupsResult.error,
          ),
        );
    }
  }

  void _getMusclesWorkouts(String musclesGroupId) async {
    emit(
      state.copyWith(
        muscleWorkoutsStatus: Status.loading,
        muscleWorkoutsError: null,
      ),
    );
    var muscleWorkoutUseCase = await _getMuscleGroupWorkoutUseCase.execute(
      musclesGroupId,
    );
    switch (muscleWorkoutUseCase) {
      case Success<List<MuscleEntity>?>():
        emit(
          state.copyWith(
            muscleWorkoutsStatus: Status.success,
            muscles: muscleWorkoutUseCase.data,
          ),
        );
      case Error<List<MuscleEntity>?>():
        emit(
          state.copyWith(
            muscleWorkoutsStatus: Status.error,
            muscleWorkoutsError: muscleWorkoutUseCase.error,
          ),
        );
    }
  }
}

sealed class HomePageIntent {}

class LoadHomePage extends HomePageIntent {}

class GetMuscleWorkouts extends HomePageIntent {
  String musclesGroupId;

  GetMuscleWorkouts({required this.musclesGroupId});
}
