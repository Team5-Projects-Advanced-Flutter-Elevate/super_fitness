import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/modules/home/data/api/api_client/home_api_client.dart';
import 'package:super_fitness/modules/home/data/data_sources_contracts/random_exercises/random_exercises_remote_data_source.dart';
import 'package:super_fitness/modules/home/data/data_sources_imp/random_exercises/random_exercises_remote_data_source_imp.dart';
import 'package:super_fitness/modules/home/data/models/random_exercises/random_exercises_request_dto.dart';
import 'package:super_fitness/modules/home/data/models/random_exercises/random_exercises_response_dto.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_request_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';
import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';

import 'random_exercises_remote_data_source_imp_test.mocks.dart';

@GenerateMocks([HomeApiClient, LocalizationManager])
void main() {
  group("RandomExercisesRemoteDataSourceImp Class Testing", () {
    late RandomExercisesRemoteDataSource randomExercisesRemoteDataSource;
    late HomeApiClient homeApiClient;
    late LocalizationManager localizationManager;
    const RandomExercisesRequestEntity randomExercisesRequestEntity =
        RandomExercisesRequestEntity(
          limit: 10,
          targetMuscleGroupId: "67c79f3526895f87ce0aa96d",
          difficultyLevelId: "67c797e226895f87ce0aa94b",
        );
    final dummyRandomExercisesResponseDto = RandomExercisesResponseDto(
      message: 'success',
      totalExercises: 1,
      exercises: [
        ExerciseDto(
          id: 'dummy_id_001',
          exercise: 'Dummy Chest Press',
          shortYoutubeDemonstration: 'Video Demonstration',
          inDepthYoutubeExplanation: 'Video Explanation',
          difficultyLevel: 'Beginner',
          targetMuscleGroup: 'Chest',
          primeMoverMuscle: 'Pectoralis Major',
          secondaryMuscle: null,
          tertiaryMuscle: null,
          primaryEquipment: 'Dumbbell',
          primaryItems: 2,
          secondaryEquipment: 'Bench (Flat)',
          secondaryItems: 1,
          posture: 'Supine',
          singleOrDoubleArm: 'Double Arm',
          continuousOrAlternatingArms: 'Continuous',
          grip: 'Neutral',
          loadPositionEnding: 'Above Chest',
          continuousOrAlternatingLegs: 'Continuous',
          footElevation: 'No Elevation',
          combinationExercises: 'Single Exercise',
          movementPattern1: 'Horizontal Push',
          movementPattern2: null,
          movementPattern3: null,
          planeOfMotion1: 'Sagittal Plane',
          planeOfMotion2: null,
          planeOfMotion3: null,
          bodyRegion: 'Upper Body',
          forceType: 'Push',
          mechanics: 'Compound',
          laterality: 'Bilateral',
          primaryExerciseClassification: 'Bodybuilding',
          shortYoutubeDemonstrationLink: 'https://youtu.be/dummyVideo1',
          inDepthYoutubeExplanationLink: 'https://youtu.be/dummyVideo2',
        ),
      ],
    );
    final query =
        RandomExercisesRequestDto.convertIntoDto(
          randomExercisesRequestEntity,
        ).toJson();
    const languageCode = "en";
    final Exception exception = Exception("Exception Test");

    setUpAll(() {
      homeApiClient = MockHomeApiClient();
      randomExercisesRemoteDataSource = RandomExercisesRemoteDataSourceImp(
        homeApiClient,
      );
      localizationManager = MockLocalizationManager();
      getIt.registerFactory(() {
        return localizationManager;
      });
      //var localizationManager = getIt.get<LocalizationManager>();
    });
    test(
      "When calling getRandomExercises(), it should call homeApiClient.getRandomExercises() and return succuss if homeApiClient.getRandomExercises() return so.",
      () async {
        // arrange
        when(
          homeApiClient.getRandomExercises(
            queries: query,
            languageCode: languageCode,
          ),
        ).thenAnswer(
          (realInvocation) => Future.value(dummyRandomExercisesResponseDto),
        );
        when(localizationManager.currentLocale).thenReturn(languageCode);

        // act
        var dataSourceResult = await randomExercisesRemoteDataSource
            .getRandomExercises(
              exercisesRequestEntity: randomExercisesRequestEntity,
            );

        // assert
        verify(
          homeApiClient.getRandomExercises(
            queries: query,
            languageCode: languageCode,
          ),
        ).called(1);
        switch (dataSourceResult) {
          case Success<RandomExercisesResponseEntity>():
            expect(
              dataSourceResult.data,
              dummyRandomExercisesResponseDto.convertIntoEntity(),
            );
          case Error<RandomExercisesResponseEntity>():
            debugPrint("Impossible Case");
        }
      },
    );
    test(
      "When calling getRandomExercises(), it should call homeApiClient.getRandomExercises() and return error if homeApiClient.getRandomExercises() return so.",
      () async {
        // arrange

        when(
          homeApiClient.getRandomExercises(
            queries: query,
            languageCode: languageCode,
          ),
        ).thenThrow(exception);
        when(localizationManager.currentLocale).thenReturn(languageCode);

        // act
        var dataSourceResult = await randomExercisesRemoteDataSource
            .getRandomExercises(
              exercisesRequestEntity: randomExercisesRequestEntity,
            );

        // assert
        verify(
          homeApiClient.getRandomExercises(
            queries: query,
            languageCode: languageCode,
          ),
        ).called(1);
        switch (dataSourceResult) {
          case Success<RandomExercisesResponseEntity>():
            debugPrint("Impossible Case");

          case Error<RandomExercisesResponseEntity>():
            expect(dataSourceResult.error, exception);
        }
      },
    );
  });
}
