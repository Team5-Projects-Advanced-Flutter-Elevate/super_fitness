import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/utilities/youtube_video_thumbnail/youtube_video_thumbnail.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';
import 'package:super_fitness/modules/home/domain/use_cases/random_exercises/get_ten_random_exerciese_use_case.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/view_model/home_page_state.dart';

@injectable
class HomePageViewModel extends Cubit<HomePageState> {
  final GetTenRandomExerciseUseCase _getTenRandomExerciseUseCase;

  HomePageViewModel(this._getTenRandomExerciseUseCase)
    : super(const HomePageState());

  void doIntent(HomePageIntent intent) {
    switch (intent) {
      case LoadHomePage():
        _getRandomExercises();
        break;
    }
  }

  void _getRandomExercises() async {
    emit(const HomePageState(randomExercisesStatus: Status.loading));
    var useCaseResult = await _getTenRandomExerciseUseCase.call();
    switch (useCaseResult) {
      case Success<RandomExercisesResponseEntity>():
        var thumbnailsList = _getVideosThumbnails(
          useCaseResult.data.exercises ?? [],
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
            error: useCaseResult.error,
          ),
        );
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
}

sealed class HomePageIntent {}

class LoadHomePage extends HomePageIntent {}
