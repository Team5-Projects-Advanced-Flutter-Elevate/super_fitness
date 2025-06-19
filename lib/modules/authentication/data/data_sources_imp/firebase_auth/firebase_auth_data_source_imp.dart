import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_executor/api_executor.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/utilities/custom_exceptions/firebase_auth_register_exception.dart';
import 'package:super_fitness/core/utilities/custom_exceptions/firebase_auth_sign_in_exception.dart';
import 'package:super_fitness/modules/authentication/data/collections/users/user_collection.dart';
import 'package:super_fitness/modules/authentication/data/data_sources_contracts/firebase_auth/firebase_auth_data_source.dart';
import 'package:super_fitness/modules/authentication/data/firebase_auth_api/google_auth_api.dart';
import 'package:super_fitness/modules/authentication/data/models/user/user_dto.dart';

@Injectable(as: FirebaseAuthDataSource)
class FirebaseAuthDataSourceImp implements FirebaseAuthDataSource {
  final GoogleAuthApi _googleAuthApi;
  final UsersCollection _usersCollection;

  FirebaseAuthDataSourceImp(this._googleAuthApi, this._usersCollection);

  @override
  Future<ApiResult<UserCredential>> signInWithGoogleAccount(
    GoogleSignInAccount googleUserAccount,
  ) async {
    var firestoreResult = await _usersCollection.searchForUserWithId(
      googleUserAccount.id,
    );
    if (firestoreResult.isEmpty) {
      return Error(error: FirebaseAuthRegisterException());
    } else {
      var result = await ApiExecutor.executeApi(
        () => _googleAuthApi.signInWithGoogle(googleUserAccount),
      );
      return result;
    }
  }

  @override
  Future<ApiResult<UserCredential>> signUpWithGoogleAccount(
    GoogleSignInAccount googleUserAccount,
    UserDto userDto,
  ) async {
    var firestoreResult = await _usersCollection.searchForUserWithId(
      googleUserAccount.id,
    );

    if (firestoreResult.isNotEmpty) {
      return Error(error: FirebaseAuthSignInException());
    } else {
      var firestoreResult = await ApiExecutor.executeApi(
        () => _usersCollection.addUser(userDto),
      );
      switch (firestoreResult) {
        case Success<void>():
          var firebaseAuthResult = await ApiExecutor.executeApi(
            () => _googleAuthApi.signInWithGoogle(googleUserAccount),
          );
          return firebaseAuthResult;
        case Error<void>():
          return Error(error: firestoreResult.error);
      }
    }
  }
}
