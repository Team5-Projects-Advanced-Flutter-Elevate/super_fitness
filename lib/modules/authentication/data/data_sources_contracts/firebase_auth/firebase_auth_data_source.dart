import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/data/models/user/user_dto.dart';

abstract interface class FirebaseAuthDataSource {
  Future<ApiResult<UserCredential>> signInWithGoogleAccount(
      GoogleSignInAccount googleUserAccount,);

  Future<ApiResult<UserCredential>> signUpWithGoogleAccount(
      GoogleSignInAccount googleUserAccount,
      UserDto userDto,);
}
