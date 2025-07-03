import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/exercise/data/datasource/exercise_datasource.dart';
import 'package:super_fitness/modules/exercise/data/repo_impl/exercise_repo_impl.dart';
import 'package:super_fitness/modules/exercise/domain/entity/exercise_entity.dart';

import 'exercise_repo_impl_test.mocks.dart';

@GenerateMocks([ExerciseOnlineDataSource])
void main() {
  group('test ExerciseRepoImpl', () {
    late ExerciseRepoImpl exerciseRepoImpl;
    late ExerciseOnlineDataSource exerciseOnlineDataSource;
    setUp(() {
      exerciseOnlineDataSource = MockExerciseOnlineDataSource();
      exerciseRepoImpl = ExerciseRepoImpl(
        exerciseOnlineDataSource,
      );
    });
    test(
      'when exercise it should call getExerciseList from datasource',
      () async {
        var result = Success<GetExerciseEntity>(
          data: const GetExerciseEntity(message: 'success', currentPage: 1, totalPages: 1, totalExercises: 1, exercises: []),
        );

        provideDummy<ApiResult<GetExerciseEntity>>(Success(data: const GetExerciseEntity(message: 'success', currentPage: 1, totalPages: 1, totalExercises: 1, exercises: [])));
        var muscleId = '123456';
        var levelId = '123456';
        when(
          exerciseOnlineDataSource.getExerciseList(muscleId, levelId),
        ).thenAnswer((_) async => result);
        var actual = await exerciseRepoImpl.getExerciseList(muscleId, levelId);
        verify(exerciseOnlineDataSource.getExerciseList(muscleId, levelId)).called(1);
        expect(actual, equals(result));
      },
    );
  });
}
