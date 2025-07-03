import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/data/data_sources_contracts/register/register_remote_data_source.dart';
import 'package:super_fitness/modules/authentication/data/repositories_imp/register/register_repo_imp.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/request/register_request_entity.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/response/register_response_entity.dart';
import 'register_repo_impl_test.mocks.dart';

@GenerateMocks([RegisterRemoteDataSource])
void main() {
  group('test RegisterRepoImpl', () {
    late RegisterRepoImp registerRepoImp;
    late RegisterRemoteDataSource registerRemoteDataSource;

    setUp(() {
      registerRemoteDataSource = MockRegisterRemoteDataSource();
      registerRepoImp = RegisterRepoImp(registerRemoteDataSource);
    });
    test('when register it should call register from datasource', () async {
  var result = Success<RegisterResponseEntity>(data: RegisterResponseEntity());

  provideDummy<ApiResult<RegisterResponseEntity>>(result);

  var email = 'mahmoud.mohamed.gamal44@gmail.com';
  var password = 'Mahmoud@123';
  var firstName = 'Elevate';
  var lastName = 'Tech';
  var gender = 'male';
  var height = 170;
  var weight = 70;
  var age = 70;
  var goal = 'Gain weight';
  var activityLevel = 'level1';

  final request = RegisterRequestEntity(
  email: email,
  password: password,
  firstName: firstName,
  lastName: lastName,
  gender: gender,
  height: height,
  weight: weight,
  age: age,
  goal: goal,
  activityLevel: activityLevel,
);

when(
  registerRemoteDataSource.register(
    registerRequestEntity: request,
  ),
).thenAnswer((_) async => result);

final actual = await registerRepoImp.register(registerRequestEntity: request);

verify(
  registerRemoteDataSource.register(registerRequestEntity: request),
).called(1);

expect(actual, equals(result));
});
  });
}