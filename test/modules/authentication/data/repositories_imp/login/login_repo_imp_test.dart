import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/data/data_sources_contracts/login/login.dart';
import 'package:super_fitness/modules/authentication/data/repositories_imp/login/login_repo_imp.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';

import 'login_repo_imp_test.mocks.dart';

@GenerateMocks([LoginOnlineDataSource])


void main() {
group('test LoginRepoImpl',(){
  late LoginRepoImpl loginRepoImpl;
  late LoginOnlineDataSource loginOnlineDataSource;

  setUp(() {
       loginOnlineDataSource=MockLoginOnlineDataSource();
       loginRepoImpl=LoginRepoImpl(loginOnlineDataSource);
  },);
  test('when login it should call login from datasource', () async {
    // TODO: Implement test

    // var result=Success<LoginEntity>([LoginEntity()]);
    var result = Success<LoginEntity>(data: LoginEntity());


    provideDummy<ApiResult<LoginEntity>>(result);
    var email='mahmoud.mohamed.gamal44@gmail.com';
    var password='Mahmoud@123';
    when(loginOnlineDataSource.login(email, password)).thenAnswer((_)async=>result);
    var actual =await loginRepoImpl.login(email, password);
    verify(loginOnlineDataSource.login(email, password)).called(1);
    expect(actual, equals(result));


  });





} );



}