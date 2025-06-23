import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api_client/workout_page_api_client.dart';

@module
abstract class WorkoutApiClientProvider {
  @lazySingleton
  WorkoutApiClient provideApiClient(Dio dio) {
    return WorkoutApiClient(dio);
  }
}
