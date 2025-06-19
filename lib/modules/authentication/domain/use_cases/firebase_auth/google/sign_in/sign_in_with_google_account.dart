import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/authentication/domain/repositories_contracts/firebase_auth/firebase_auth_repo.dart';

import '../../../../../../../core/apis/api_result/api_result.dart';

@injectable
class SignInWithGoogleAccountUseCase {
  final FirebaseAuthRepo _firebaseAuthRepo;

  SignInWithGoogleAccountUseCase(this._firebaseAuthRepo);

  Future<ApiResult<UserCredential>> call(
      GoogleSignInAccount googleUserAccount,) {
    return _firebaseAuthRepo.signInWithGoogleAccount(googleUserAccount);
  }
}
