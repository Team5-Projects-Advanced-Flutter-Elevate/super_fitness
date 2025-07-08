import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/data/data_sources_contracts/random_exercises/random_exercises_remote_data_source.dart';
import 'package:super_fitness/modules/home/data/models/random_exercises/random_exercises_response_dto.dart';
import 'package:super_fitness/modules/home/data/respositories_imp/random_exercises/random_exercises_repo_imp.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_request_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';
import 'package:super_fitness/modules/home/domain/repositories_contracts/random_exercises/random_exercise_repo.dart';

import 'random_exercises_repo_imp_test.mocks.dart';

@GenerateMocks([RandomExercisesRemoteDataSource])
void main() {
  late RandomExercisesRemoteDataSource randomExercisesRemoteDataSource;
  late RandomExercisesRepo randomExercisesRepo;
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
  final Exception exception = Exception("Exception Test");
  group("RandomExercisesRepoImp class Testing", () {
    setUpAll(() {
      randomExercisesRemoteDataSource = MockRandomExercisesRemoteDataSource();
      randomExercisesRepo = RandomExercisesRepoImp(
        randomExercisesRemoteDataSource,
      );
    });
    test(
      "When calling getRandomExercises(), it should call randomExercisesRemoteDataSource.getRandomExercises() and return success if the latter function returns so.",
      () async {
        // arrange
        provideDummy<ApiResult<RandomExercisesResponseEntity>>(
          Success(data: dummyRandomExercisesResponseDto.convertIntoEntity()),
        );
        when(
          randomExercisesRemoteDataSource.getRandomExercises(
            exercisesRequestEntity: randomExercisesRequestEntity,
          ),
        ).thenAnswer(
          (realInvocation) => Future.value(
            Success(data: dummyRandomExercisesResponseDto.convertIntoEntity()),
          ),
        );

        // act
        var repoResult = await randomExercisesRepo.getRandomExercises(
          exercisesRequestEntity: randomExercisesRequestEntity,
        );

        // assert
        verify(
          randomExercisesRemoteDataSource.getRandomExercises(
            exercisesRequestEntity: randomExercisesRequestEntity,
          ),
        ).called(1);
        switch (repoResult) {
          case Success<RandomExercisesResponseEntity>():
            expect(
              repoResult.data,
              dummyRandomExercisesResponseDto.convertIntoEntity(),
            );
          case Error<RandomExercisesResponseEntity>():
            debugPrint("Impossible Case");
        }
      },
    );
    test(
      "When calling getRandomExercises(), it should call randomExercisesRemoteDataSource.getRandomExercises() and return error if the latter function returns so.",
      () async {
        // arrange
        provideDummy<ApiResult<RandomExercisesResponseEntity>>(
          Error(error: exception),
        );
        when(
          randomExercisesRemoteDataSource.getRandomExercises(
            exercisesRequestEntity: randomExercisesRequestEntity,
          ),
        ).thenAnswer((realInvocation) => Future.value(Error(error: exception)));

        // act
        var repoResult = await randomExercisesRepo.getRandomExercises(
          exercisesRequestEntity: randomExercisesRequestEntity,
        );

        // assert
        verify(
          randomExercisesRemoteDataSource.getRandomExercises(
            exercisesRequestEntity: randomExercisesRequestEntity,
          ),
        ).called(1);
        switch (repoResult) {
          case Success<RandomExercisesResponseEntity>():
            debugPrint("Impossible Case");

          case Error<RandomExercisesResponseEntity>():
            expect(repoResult.error, exception);
        }
      },
    );
  });
}
