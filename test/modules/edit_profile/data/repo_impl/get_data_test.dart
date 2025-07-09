import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/edit_profile/data/datasource/get_data.dart';
import 'package:super_fitness/modules/edit_profile/data/repo_impl/get_data.dart';
import 'package:super_fitness/modules/edit_profile/domain/entity/get_data_entity.dart';

import 'get_data_test.mocks.dart';

@GenerateMocks([GetLoggedDriverDataOnlineDataSource])
void main() {
  group('test LoginRepoImpl', () {
    late LoggedDriverDataRepoImp loggedDriverDataRepoImp;
    late GetLoggedDriverDataOnlineDataSource
    getLoggedDriverDataOnlineDataSource;

    setUp(() {
      getLoggedDriverDataOnlineDataSource =
          MockGetLoggedDriverDataOnlineDataSource();
      loggedDriverDataRepoImp = LoggedDriverDataRepoImp(
        getLoggedDriverDataOnlineDataSource,
      );
    });
    test(
      'when get data  it should call getLoggedDriverData from datasource',
      () async {
        var result = Success<GetDataEntity>(data: const GetDataEntity());

        provideDummy<ApiResult<GetDataEntity>>(result);

        when(
          getLoggedDriverDataOnlineDataSource.getLoggedDriverData(),
        ).thenAnswer((_) async => result);
        var actual = await loggedDriverDataRepoImp.getLoggedDriverData();
        verify(
          getLoggedDriverDataOnlineDataSource.getLoggedDriverData(),
        ).called(1);
        expect(actual, equals(result));
      },
    );
  });
}
