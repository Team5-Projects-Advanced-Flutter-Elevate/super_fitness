import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/data/data_sources_contracts/firebase_auth/firebase_auth_data_source.dart';
import 'package:super_fitness/modules/authentication/data/models/user/user_dto.dart';
import 'package:super_fitness/modules/authentication/domain/repositories_contracts/firebase_auth/firebase_auth_repo.dart';

@Injectable(as: FirebaseAuthRepo)
class FirebaseAuthRepoImp implements FirebaseAuthRepo {
  final FirebaseAuthDataSource _firebaseAuthDataSource;

  FirebaseAuthRepoImp(this._firebaseAuthDataSource);

  @override
  Future<ApiResult<UserCredential>> signInWithGoogleAccount(
    GoogleSignInAccount googleUserAccount,
  ) {
    return _firebaseAuthDataSource.signInWithGoogleAccount(googleUserAccount);
  }

  @override
  Future<ApiResult<UserCredential>> signUpWithGoogleAccount(
    GoogleSignInAccount googleUserAccount,
    UserDto userDto,
  ) {
    return _firebaseAuthDataSource.signUpWithGoogleAccount(
      googleUserAccount,
      userDto,
    );
  }
}
