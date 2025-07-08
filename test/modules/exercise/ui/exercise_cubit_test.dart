import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/exercise/domain/entity/exercise_entity.dart';
import 'package:super_fitness/modules/exercise/domain/usecase/exercise_usecase.dart';
import 'package:super_fitness/modules/exercise/ui/cubit/state.dart';
import 'package:super_fitness/modules/exercise/ui/cubit/view_model.dart';

import 'exercise_cubit_test.mocks.dart';

@GenerateMocks([ExerciseUseCase])
void main() {
  setUpAll(() {
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
  });
  TestWidgetsFlutterBinding.ensureInitialized();
  group('ExerciseViewModel', () {
    late ExerciseViewModel exerciseViewModel;
    late ExerciseUseCase mockExerciseUseCase;

    setUp(() {
      mockExerciseUseCase = MockExerciseUseCase();

      when(mockExerciseUseCase.call('1', '1')).thenAnswer(
        (_) async => Success<GetExerciseEntity>(
          data: const GetExerciseEntity(
            message: 'Success',
            currentPage: 1,
            totalPages: 1,
            totalExercises: 1,
            exercises: [],
          ),
        ),
      );
      when(mockExerciseUseCase.call('1', '1')).thenAnswer(
        (_) async => Success<GetExerciseEntity>(
          data: const GetExerciseEntity(
            message: 'Success',
            currentPage: 1,
            totalPages: 1,
            totalExercises: 1,
            exercises: [],
          ),
        ),
      );
      when(mockExerciseUseCase.call('1', '1')).thenAnswer(
        (_) async => Success<GetExerciseEntity>(
          data: const GetExerciseEntity(
            message: 'Success',
            currentPage: 1,
            totalPages: 1,
            totalExercises: 1,
            exercises: [],
          ),
        ),
      );

      exerciseViewModel = ExerciseViewModel(mockExerciseUseCase);
    });

    blocTest<ExerciseViewModel, ExerciseState>(
      'emits loading then success state when exercise use case returns success',
      build: () {
        when(mockExerciseUseCase.call('1', '1')).thenAnswer(
          (_) async => Success<GetExerciseEntity>(
            data: const GetExerciseEntity(
              message: 'Success',
              currentPage: 1,
              totalPages: 1,
              totalExercises: 1,
              exercises: [],
            ),
          ),
        );
        return exerciseViewModel;
      },
      act: (cubit) => cubit.doIntent(Exercise('1', '1')),
      expect:
          () => [
            const ExerciseState(
              status: Status.loading,
              exercises: [],
              thumbnailUrl: [],
              thumbnailStatus: Status.idle,
              selectedLevelId: '',
              selectedShortLink: '',
              selectedThumbnailUrl: '',
              error: null,
            ),
            const ExerciseState(
              status: Status.success,
              exercises: [],
              thumbnailUrl: [],
              thumbnailStatus: Status.idle,
              selectedLevelId: '',
              selectedShortLink: '',
              selectedThumbnailUrl: '',
              error: null,
            ),
          ],
    );

    blocTest<ExerciseViewModel, ExerciseState>(
      'emits error state when use case returns error',
      build: () {
        when(mockExerciseUseCase.call('1', '1')).thenAnswer(
          (_) async => Error<GetExerciseEntity>(error: 'Error message'),
        );
        return exerciseViewModel;
      },
      act: (cubit) => cubit.doIntent(Exercise('1', '1')),
      expect:
          () => [
            const ExerciseState(
              status: Status.loading,
              exercises: [],
              thumbnailUrl: [],
              thumbnailStatus: Status.idle,
              selectedLevelId: '',
              selectedShortLink: '',
              selectedThumbnailUrl: '',
              error: null,
            ),
            const ExerciseState(
              status: Status.error,
              exercises: [],
              thumbnailUrl: [],
              thumbnailStatus: Status.idle,
              selectedLevelId: '',
              selectedShortLink: '',
              selectedThumbnailUrl: '',
              error: 'Error message',
            ),
          ],
    );
  });
}
