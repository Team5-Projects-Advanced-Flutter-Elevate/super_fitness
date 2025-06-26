import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:super_fitness/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:super_fitness/modules/home/data/models/workouts/get_all_muscles_group_response.dart';
import 'package:super_fitness/modules/home/data/models/workouts/muscle_group_workouts.dart';
import 'package:super_fitness/modules/home/data/models/random_exercises/random_exercises_response_dto.dart';

part 'home_api_client.g.dart';

@RestApi()
abstract class HomeApiClient {
  factory HomeApiClient(Dio dio) = _HomeApiClient;

  @GET(ApisEndpoints.randomExercisesEndPoint)
  Future<RandomExercisesResponseDto> getRandomExercises({
    @Queries() required Map<String, dynamic> queries,
    @Header("Accept-Language") required String languageCode,
  });

  @GET(ApisEndpoints.musclesGroup)
  Future<GetMusclesGroupResponse> getMusclesGroup();

  @GET(ApisEndpoints.musclesGroupWorkouts)
  Future<MuscleGroupWorkoutsResponse> getMusclesGroupWorkouts(
    @Path('id') String id,
  );
}
