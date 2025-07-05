import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/utilities/custom_exceptions/social_login_exception.dart';
import 'package:super_fitness/core/utilities/social_accounts_sign_in/facebook_sign_in/facebook_response_model.dart';

@injectable
class FacebookSignInHandler {
  Future<ApiResult<FacebookResponseModel>> getUserFacebookAccount() async {
    try {
      final facebookInstance = FacebookAuth.instance;
      await facebookInstance.logOut();
      var loginResult = await facebookInstance.login(
        permissions: ['email', 'public_profile'],
      );
      if (loginResult.status == LoginStatus.success &&
          loginResult.accessToken != null) {
        final userData = await facebookInstance.getUserData(
          fields: "name,email,picture.width(200)",
        );

        debugPrint("User Data: $userData");
        return Success(data: FacebookResponseModel.fromJson(userData));
      } else {
        debugPrint("Facebook login failed: ${loginResult.status}");
        return Error(
          error: SocialLoginException(
              "Facebook login failed: ${loginResult.status}"),
        );
      }
    } catch (e) {
      debugPrint("Error during Facebook login: $e");
      return Error(
          error: SocialLoginException("Error during Facebook login: $e"));
    }
  }
}
