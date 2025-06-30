import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/apis/apis_endpoints/apis_endpoints.dart';
import '../../model/edit_info.dart';
import '../../model/get_data.dart';

part 'get_data_api_client.g.dart';

@RestApi(baseUrl: ApisEndpoints.baseUrl)
abstract class GetDataApiClient {
  factory GetDataApiClient(Dio dio) = _GetDataApiClient;

  @GET(ApisEndpoints.getLoggedData)
  Future<GetData> getLoggedDriverData();

  @PUT(ApisEndpoints.editProfile)
  Future<EditMyInfo> editInfo(@Body() Map<String, dynamic> body);


}
