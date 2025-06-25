import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness/modules/exercise/data/model/get_exercise.dart';

import '../../../../../core/apis/apis_endpoints/apis_endpoints.dart';

part 'exercise_api_client.g.dart';

@RestApi(baseUrl: ApisEndpoints.baseUrl)
abstract class ExerciseApiClient {
  factory ExerciseApiClient(Dio dio) = _ExerciseApiClient;

  @GET(ApisEndpoints.exerciseById)
  Future<GetExerciseModel> exercise({
    @Query("primeMoverMuscleId") required String muscleId,
    @Query("difficultyLevelId") required String levelId,
  });
}
