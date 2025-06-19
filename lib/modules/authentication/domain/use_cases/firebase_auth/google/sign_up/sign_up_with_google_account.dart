import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/authentication/domain/repositories_contracts/firebase_auth/firebase_auth_repo.dart';

import '../../../../../../../core/apis/api_result/api_result.dart';
import '../../../../../data/models/user/user_dto.dart';

@injectable
class SignUpWithGoogleAccountUseCase {
  final FirebaseAuthRepo _firebaseAuthRepo;

  SignUpWithGoogleAccountUseCase(this._firebaseAuthRepo);

  Future<ApiResult<UserCredential>> call(GoogleSignInAccount googleUserAccount,
      UserDto userDto,) {
    return _firebaseAuthRepo.signUpWithGoogleAccount(
      googleUserAccount,
      userDto,
    );
  }
}
