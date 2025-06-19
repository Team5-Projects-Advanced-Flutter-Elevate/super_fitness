import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class GoogleSignInHandler {
  final GoogleSignIn _googleSignIn;

  GoogleSignInHandler(this._googleSignIn);

  Future<GoogleSignInAccount?> getUserGoogleAccount() async {
    await _googleSignIn.signOut();
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    return googleUser;
  }
}
