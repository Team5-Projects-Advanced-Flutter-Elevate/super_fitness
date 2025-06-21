import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/exercise/domain/entity/get_exercise.dart';
import 'package:super_fitness/modules/exercise/domain/usecase/exercise_usecase.dart';
import 'package:super_fitness/modules/exercise/ui/cubit/state.dart';

import '../../../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/exercise_entity.dart';

@injectable
class ExerciseViewModel extends Cubit<ExerciseState> {
  final ExerciseUseCase _exerciseUseCase;

  ExerciseViewModel(this._exerciseUseCase) : super(const ExerciseState());

  void doIntent(ExerciseIntent intent) {
    switch (intent) {
      case Exercise():
        _exercise(intent.muscleId, intent.levelId);
    }
  }

  void _exercise(String muscleId, String levelId) async {
    emit(const ExerciseState(status: Status.loading));
    var result = await _exerciseUseCase.call(muscleId, levelId);
    switch (result) {
      case Success<GetExerciseEntity>():
        final list=result.data;
        emit(ExerciseState(status: Status.success,exercises:result.data.exercises ));
      case Error<GetExerciseEntity>():
        emit(ExerciseState(status: Status.error, error: result.error));
    }
  }
}

sealed class ExerciseIntent {}

class Exercise extends ExerciseIntent {
  final String muscleId;
  final String levelId;
  Exercise(this.muscleId, this.levelId);
}
