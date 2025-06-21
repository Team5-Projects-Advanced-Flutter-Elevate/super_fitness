import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api_client/exercise_api_client.dart';

@module
abstract class ExerciseApiClientProvider {
  @lazySingleton
  ExerciseApiClient provideApiClient(Dio dio) {
    return ExerciseApiClient(dio);
  }
}
