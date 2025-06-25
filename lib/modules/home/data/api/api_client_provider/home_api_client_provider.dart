import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/home/data/api/api_client/home_api_client.dart';

@module
abstract class HomeApiClientProvider {
  @lazySingleton
  HomeApiClient provideApiClient(Dio dio) {
    return HomeApiClient(dio);
  }
}
