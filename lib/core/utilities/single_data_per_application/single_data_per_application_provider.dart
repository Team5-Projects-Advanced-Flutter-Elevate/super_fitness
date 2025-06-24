import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';

@lazySingleton
class SingleDataPerApplicationProvider extends ChangeNotifier {
  RandomExercisesResponseEntity? _randomExercisesResponse;
  List<String>? _exercisesVideosThumbnailsUrls;

  RandomExercisesResponseEntity? get randomExercisesResponse =>
      _randomExercisesResponse;

  List<String>? get exercisesVideosThumbnailsUrls =>
      _exercisesVideosThumbnailsUrls;

  void changeRandomExercisesData({
    required RandomExercisesResponseEntity entity,
    required List<String> thumbnailsUrls,
  }) {
    _randomExercisesResponse = entity;
    _exercisesVideosThumbnailsUrls = thumbnailsUrls;
    notifyListeners();
  }
}
