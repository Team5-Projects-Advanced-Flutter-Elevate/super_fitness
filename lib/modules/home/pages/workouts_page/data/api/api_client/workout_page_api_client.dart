import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:super_fitness/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/data/models/get_all_muscles_group_response.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/data/models/muscle_group_workouts.dart';

part 'workout_page_api_client.g.dart';

@RestApi()
abstract class WorkoutApiClient {
  factory WorkoutApiClient(Dio dio) = _WorkoutApiClient;

  @GET(ApisEndpoints.musclesGroup)
  Future<GetMusclesGroupResponse> getMusclesGroup();

  @GET(ApisEndpoints.musclesGroupWorkouts)
  Future<MuscleGroupWorkoutsResponse> getMusclesGroupWorkouts(
    @Path('id') String id,
  );
}
