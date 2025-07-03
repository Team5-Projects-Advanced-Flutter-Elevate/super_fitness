import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/exercise/domain/entity/exercise_entity.dart';
import 'package:super_fitness/modules/exercise/domain/repo/exercise_repo.dart';
import 'package:super_fitness/modules/exercise/domain/usecase/exercise_usecase.dart';

import 'exercise_test.mocks.dart';

@GenerateMocks([ExerciseRepo])
void main() {
  group('test ExerciseRepoImpl', () {
    late ExerciseRepo exerciseRepo;
    late ExerciseUseCase exerciseUseCase;
    setUp(() {
      exerciseRepo = MockExerciseRepo();
      exerciseUseCase = ExerciseUseCase(exerciseRepo);
    });
    test(
      'when call exercise password function it should call getExerciseList from repo',
      () async {
        var result = Success<GetExerciseEntity>(
          data: const GetExerciseEntity(
            message: 'success',
            currentPage: 1,
            totalPages: 1,
            totalExercises: 1,
            exercises: [],
          ),
        );

        provideDummy<ApiResult<GetExerciseEntity>>(
          Success(
            data: const GetExerciseEntity(
              message: 'success',
              currentPage: 1,
              totalPages: 1,
              totalExercises: 1,
              exercises: [],
            ),
          ),
        );
        var muscleId = '123456';
        var levelId = '123456';
        when(
          exerciseRepo.getExerciseList(muscleId, levelId),
        ).thenAnswer((_) async => result);
        var actual = await exerciseUseCase.call(muscleId, levelId);
        verify(exerciseRepo.getExerciseList(muscleId, levelId)).called(1);
        expect(actual, equals(result));
      },
    );
  });
}
