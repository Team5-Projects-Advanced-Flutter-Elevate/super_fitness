import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_executor/api_executor.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/modules/home/data/api/api_client/home_api_client.dart';
import 'package:super_fitness/modules/home/data/data_sources_contracts/random_exercises/random_exercises_remote_data_source.dart';
import 'package:super_fitness/modules/home/data/models/random_exercises/random_exercises_request_dto.dart';
import 'package:super_fitness/modules/home/data/models/random_exercises/random_exercises_response_dto.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_request_entity.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';
import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';

@Injectable(as: RandomExercisesRemoteDataSource)
class RandomExercisesRemoteDataSourceImp
    implements RandomExercisesRemoteDataSource {
  final HomeApiClient _homeApiClient;

  RandomExercisesRemoteDataSourceImp(this._homeApiClient);

  @override
  Future<ApiResult<RandomExercisesResponseEntity>> getRandomExercises({
    required RandomExercisesRequestEntity exercisesRequestEntity,
  }) async {
    var result = await ApiExecutor.executeApi(
      () => _homeApiClient.getRandomExercises(
        queries:
            RandomExercisesRequestDto.convertIntoDto(
              exercisesRequestEntity,
            ).toJson(),
        languageCode: getIt.get<LocalizationManager>().currentLocale,
      ),
    );
    switch (result) {
      case Success<RandomExercisesResponseDto>():
        return Success(data: result.data.convertIntoEntity());
      case Error<RandomExercisesResponseDto>():
        return Error(error: result.error);
    }
  }
}
