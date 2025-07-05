import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/utilities/single_data_per_application/single_data_per_application_provider.dart';
import 'package:super_fitness/modules/food/domain/entities/food_categories_entity.dart';
import 'package:super_fitness/modules/food/domain/use_cases/get_food_categories_use_case.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscle_group_workout_response_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscles_group_response_entity.dart';
import 'package:super_fitness/modules/home/domain/use_cases/random_exercises/get_ten_random_exerciese_use_case.dart';
import 'package:super_fitness/modules/home/domain/use_cases/workouts/get_muscle_group_workout_use_case.dart';
import 'package:super_fitness/modules/home/domain/use_cases/workouts/get_muscles_group_use_case.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/view_model/home_page_state.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/view_model/home_page_view_model.dart';

import 'home_page_view_model_test.mocks.dart';

@GenerateMocks([
  GetTenRandomExerciseUseCase,
  GetFoodCategoriesUseCase,
  GetMusclesGroupUseCase,
  GetMuscleGroupWorkoutUseCase,
  SingleDataPerApplicationProvider,
])
void main() {
  group("HomePageViewModel class Testing", () {
    late GetTenRandomExerciseUseCase getTenRandomExerciseUseCase;
    late GetFoodCategoriesUseCase getFoodCategoriesUseCase;
    late GetMusclesGroupUseCase getMusclesGroupUseCase;
    late GetMuscleGroupWorkoutUseCase getMuscleGroupWorkoutUseCase;
    late HomePageViewModel homePageViewModel;
    late SingleDataPerApplicationProvider singleDataPerApplicationProvider;
    const dummyExercise = ExerciseEntity(
      id: '1',
      exercise: 'Push-Up',
      shortYoutubeDemonstration: 'Short demo of push-up',
      inDepthYoutubeExplanation: 'Detailed push-up tutorial',
      difficultyLevel: 'Beginner',
      targetMuscleGroup: 'Chest',
      primeMoverMuscle: 'Pectoralis Major',
      primaryEquipment: 'None',
      primaryItems: 0,
      secondaryItems: 0,
      posture: 'Prone',
      singleOrDoubleArm: 'Double',
      continuousOrAlternatingArms: 'Continuous',
      grip: 'Neutral',
      loadPositionEnding: 'Bodyweight',
      continuousOrAlternatingLegs: 'None',
      footElevation: 'Flat',
      combinationExercises: 'None',
      movementPattern1: 'Push',
      planeOfMotion1: 'Sagittal',
      bodyRegion: 'Upper Body',
      forceType: 'Push',
      mechanics: 'Compound',
      laterality: 'Bilateral',
      primaryExerciseClassification: 'Bodyweight',
      shortYoutubeDemonstrationLink: 'https://youtu.be/demo_pushup_short',
      inDepthYoutubeExplanationLink: 'https://youtu.be/demo_pushup_detailed',
    );

    const randomExercisesResponseEntity = RandomExercisesResponseEntity(
      message: 'Success',
      totalExercises: 1,
      exercises: [dummyExercise],
    );

    const foodCategoryEntity = FoodCategoryEntity(
      idCategory: '1',
      strCategory: 'Vegetarian',
      strCategoryThumb: 'https://www.example.com/images/vegetarian.jpg',
      strCategoryDescription:
          'Foods that contain no meat or fish, suitable for vegetarians.',
    );
    final foodCategoryEntities = [foodCategoryEntity];
    const dummyMuscleGroup = MuscleGroupEntity(id: 'mg1', name: 'Chest');
    final muscleGroups = [dummyMuscleGroup];
    const dummyMuscle = MuscleEntity(
      id: 'm1',
      name: 'Biceps',
      image: 'https://www.example.com/images/biceps.png',
    );
    final muscleEntities = [dummyMuscle];
    const muscleGroupId = '31231342355657';
    setUpAll(() {
      getTenRandomExerciseUseCase = MockGetTenRandomExerciseUseCase();
      getFoodCategoriesUseCase = MockGetFoodCategoriesUseCase();
      getMusclesGroupUseCase = MockGetMusclesGroupUseCase();
      getMuscleGroupWorkoutUseCase = MockGetMuscleGroupWorkoutUseCase();
      singleDataPerApplicationProvider = MockSingleDataPerApplicationProvider();
      getIt.registerLazySingleton(() => singleDataPerApplicationProvider);
    });
    setUp(() {
      homePageViewModel = HomePageViewModel(
        getTenRandomExerciseUseCase,
        getFoodCategoriesUseCase,
        getMusclesGroupUseCase,
        getMuscleGroupWorkoutUseCase,
      );
    });
    blocTest(
      "When calling doIntent() function of the HomePageViewModel with the intent value LoadHomePage(), it should emit the correct states until it reaches the state with success status if the call of the function was success too.",
      build: () => homePageViewModel,
      act: (homePageViewModel) {
        when(
          singleDataPerApplicationProvider.randomExercisesResponse,
        ).thenReturn(null);
        when(
          singleDataPerApplicationProvider.exercisesVideosThumbnailsUrls,
        ).thenReturn(null);
        provideDummy<ApiResult<RandomExercisesResponseEntity>>(
          Success(data: randomExercisesResponseEntity),
        );
        when(getTenRandomExerciseUseCase.call()).thenAnswer(
          (realInvocation) =>
              Future.value(Success(data: randomExercisesResponseEntity)),
        );
        provideDummy<ApiResult<List<FoodCategoryEntity>>>(
          Success(data: foodCategoryEntities),
        );
        when(getFoodCategoriesUseCase.call()).thenAnswer(
          (realInvocation) => Future.value(Success(data: foodCategoryEntities)),
        );
        provideDummy<ApiResult<List<MuscleGroupEntity>?>>(
          Success(data: muscleGroups),
        );
        when(getMusclesGroupUseCase.execute()).thenAnswer(
          (realInvocation) => Future.value(Success(data: muscleGroups)),
        );
        provideDummy<ApiResult<List<MuscleEntity>?>>(
          Success(data: muscleEntities),
        );
        when(getMuscleGroupWorkoutUseCase.execute(muscleGroupId)).thenAnswer(
          (realInvocation) => Future.value(Success(data: muscleEntities)),
        );
        homePageViewModel.doIntent(LoadHomePage());
      },
      verify: (bloc) {
        verify(getTenRandomExerciseUseCase.call()).called(1);
        verify(getFoodCategoriesUseCase.call()).called(1);
        verify(getMusclesGroupUseCase.execute()).called(1);
        verifyNever(
          getMuscleGroupWorkoutUseCase.execute(muscleGroupId),
        ).called(0);
      },
      expect:
          () => [
            const HomePageState(randomExercisesStatus: Status.loading),
            const HomePageState(
              randomExercisesStatus: Status.loading,
              foodCategoriesStatus: Status.loading,
            ),
            const HomePageState(
              randomExercisesStatus: Status.loading,
              foodCategoriesStatus: Status.loading,
              musclesGroupsStatus: Status.loading,
            ),
            const HomePageState(
              randomExercisesStatus: Status.success,
              foodCategoriesStatus: Status.loading,
              musclesGroupsStatus: Status.loading,
              randomExercisesResponse: randomExercisesResponseEntity,
              exercisesVideosThumbnailsUrls: [
                "https://img.youtube.com/vi/demo_pushup_short/0.jpg",
              ],
            ),
            HomePageState(
              randomExercisesStatus: Status.success,
              foodCategoriesStatus: Status.success,
              musclesGroupsStatus: Status.loading,
              randomExercisesResponse: randomExercisesResponseEntity,
              exercisesVideosThumbnailsUrls: [
                "https://img.youtube.com/vi/demo_pushup_short/0.jpg",
              ],

              foodCategoryEntities: foodCategoryEntities,
            ),
            HomePageState(
              randomExercisesStatus: Status.success,
              foodCategoriesStatus: Status.success,
              musclesGroupsStatus: Status.success,
              randomExercisesResponse: randomExercisesResponseEntity,
              exercisesVideosThumbnailsUrls: [
                "https://img.youtube.com/vi/demo_pushup_short/0.jpg",
              ],
              foodCategoryEntities: foodCategoryEntities,
              musclesGroups: muscleGroups,
            ),
          ],
    );
    blocTest(
      "When calling doIntent() function of the HomePageViewModel with the intent value GetMuscleWorkouts(), it should emit the correct states until it reaches the state with success status if the call of the function was success too.",
      build: () => homePageViewModel,
      act: (homePageViewModel) {
        when(
          singleDataPerApplicationProvider.randomExercisesResponse,
        ).thenReturn(null);
        when(
          singleDataPerApplicationProvider.exercisesVideosThumbnailsUrls,
        ).thenReturn(null);
        provideDummy<ApiResult<RandomExercisesResponseEntity>>(
          Success(data: randomExercisesResponseEntity),
        );
        when(getTenRandomExerciseUseCase.call()).thenAnswer(
          (realInvocation) =>
              Future.value(Success(data: randomExercisesResponseEntity)),
        );
        provideDummy<ApiResult<List<FoodCategoryEntity>>>(
          Success(data: foodCategoryEntities),
        );
        when(getFoodCategoriesUseCase.call()).thenAnswer(
          (realInvocation) => Future.value(Success(data: foodCategoryEntities)),
        );
        provideDummy<ApiResult<List<MuscleGroupEntity>?>>(
          Success(data: muscleGroups),
        );
        when(getMusclesGroupUseCase.execute()).thenAnswer(
          (realInvocation) => Future.value(Success(data: muscleGroups)),
        );
        provideDummy<ApiResult<List<MuscleEntity>?>>(
          Success(data: muscleEntities),
        );
        when(getMuscleGroupWorkoutUseCase.execute(muscleGroupId)).thenAnswer(
          (realInvocation) => Future.value(Success(data: muscleEntities)),
        );
        homePageViewModel.doIntent(
          GetMuscleWorkouts(musclesGroupId: muscleGroupId),
        );
      },
      verify: (bloc) {
        verifyNever(getTenRandomExerciseUseCase.call()).called(0);
        verifyNever(getFoodCategoriesUseCase.call()).called(0);
        verifyNever(getMusclesGroupUseCase.execute()).called(0);
        verify(getMuscleGroupWorkoutUseCase.execute(muscleGroupId)).called(1);
      },
      expect:
          () => [
            const HomePageState(muscleWorkoutsStatus: Status.loading),
            HomePageState(
              muscleWorkoutsStatus: Status.success,
              muscles: muscleEntities,
            ),
          ],
    );
  });
}
