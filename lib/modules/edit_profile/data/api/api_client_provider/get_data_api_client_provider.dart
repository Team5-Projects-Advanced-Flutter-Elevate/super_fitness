import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api_client/get_data_api_client.dart';

@module
abstract class GetDataApiClientProvider {
  @lazySingleton
  GetDataApiClient provideApiClient(Dio dio) {
    return GetDataApiClient(dio);
  }
}
