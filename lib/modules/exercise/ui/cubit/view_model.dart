import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
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
        break;
      case SelectThumbnail():
        _selectThumbnail(intent.thumbnailUrl);
        break;
    }
  }

  void _exercise(String muscleId, String levelId) async {
    emit(const ExerciseState(status: Status.loading));

    var result = await _exerciseUseCase.call(muscleId, levelId);
    switch (result) {
      case Success<GetExerciseEntity>():
        final exercises = result.data.exercises;

        // Generate thumbnail list
        final thumbnails =
            exercises
                .map(
                  (e) => getYoutubeThumbnail(
                    e.inDepthYoutubeExplanationLink.toString(),
                  ),
                )
                .toList();

        emit(
          state.copyWith(
            status: Status.success,
            exercises: exercises,
            thumbnailUrl: thumbnails,
          ),
        );
        break;

      case Error<GetExerciseEntity>():
        emit(state.copyWith(status: Status.error, error: result.error));
    }
  }

  void _selectThumbnail(String url) {
    emit(state.copyWith(selectedThumbnailUrl: url));
  }

  String getYoutubeThumbnail(String url) {
    Uri uri = Uri.parse(url);

    if (uri.host.contains("youtu.be")) {
      return 'https://img.youtube.com/vi/${uri.pathSegments.first}/hqdefault.jpg';
    }

    // Standard YouTube link
    final videoId = uri.queryParameters['v'];
    return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
  }
}

sealed class ExerciseIntent {}

class Exercise extends ExerciseIntent {
  final String muscleId;
  final String levelId;
  Exercise(this.muscleId, this.levelId);
}

class SelectThumbnail extends ExerciseIntent {
  final String thumbnailUrl;
  SelectThumbnail(this.thumbnailUrl);
}
