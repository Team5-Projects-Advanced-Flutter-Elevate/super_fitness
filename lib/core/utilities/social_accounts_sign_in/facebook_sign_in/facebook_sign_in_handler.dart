import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class FacebookSignInHandler {
  Future<Map<String, dynamic>?> getUserFacebookAccount() async {
    print("========== inside get user facebook account");
    final facebookInstance = FacebookAuth.instance;
    //await facebookInstance.logOut();
    var loginResult = await facebookInstance.login(
      permissions: ['email', 'public_profile'],
    );
    if (loginResult.status == LoginStatus.success) {
      final AccessToken accessToken = loginResult.accessToken!;

      final userData = await facebookInstance.getUserData(
        fields: "name,email,picture.width(200),phone",
      );

      print("User Data: $userData");
      return userData;
    } else {
      print("Facebook login failed: ${loginResult.status}");
      return null;
    }
  }
}
