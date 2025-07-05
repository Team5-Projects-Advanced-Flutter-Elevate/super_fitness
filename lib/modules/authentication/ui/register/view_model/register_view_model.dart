import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/obfuscation/password/obfuscated_password.dart';
import 'package:super_fitness/core/utilities/activities/activities.dart';
import 'package:super_fitness/core/utilities/goals/goals.dart';
import 'package:super_fitness/core/utilities/social_accounts_sign_in/facebook_sign_in/facebook_response_model.dart';
import 'package:super_fitness/core/utilities/social_accounts_sign_in/facebook_sign_in/facebook_sign_in_handler.dart';
import 'package:super_fitness/core/utilities/social_accounts_sign_in/google_sign_in/google_sign_in_handler.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/request/register_request_entity.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/response/register_response_entity.dart';
import 'package:super_fitness/modules/authentication/domain/use_cases/register/register_use_case.dart';
import 'package:super_fitness/modules/authentication/ui/register/view_model/register_state.dart';
import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';

enum RegisterMethod {
  initial,
  apiRegister,
  googleRegister,
  facebookRegister,
  appleRegister,
}

@injectable
class RegisterViewModel extends Cubit<RegisterState> {
  final RegisterUserCase _registerUserCase;
  final GoogleSignInHandler _googleSignInHandler;
  final FacebookSignInHandler _facebookSignInHandler;

  RegisterViewModel(
    this._registerUserCase,
    this._googleSignInHandler,
    this._facebookSignInHandler,
  ) : super(const RegisterState());

  TextEditingController firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmPasswordController = TextEditingController();

  FocusNode firstNameNode = FocusNode(),
      lastNameNode = FocusNode(),
      emailNode = FocusNode(),
      passwordNode = FocusNode(),
      confirmPasswordNode = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PageController pageViewController = PageController(initialPage: 0);

  RegisterMethod currentRegisterMethod = RegisterMethod.initial;

  SocialAccountInfo? _socialAccountInfo;

  void doIntent(RegisterIntent intent) {
    switch (intent) {
      case RegisterUser():
        _apiRegister(restOfRegisterRequest: intent.restOfRegisterRequest);
        break;
      case OnAnyRegisterButtonClick():
        _onAnyRegisterButtonClick();
        break;
      case ClearControllers():
        _clearControllers();
        break;
    }
  }

  void _apiRegister({
    required RestOfRegisterRequest restOfRegisterRequest,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(const RegisterState(registerStatus: Status.loading));
    var isSocialAccount = (currentRegisterMethod != RegisterMethod.apiRegister);
    var useCaseResult = await _registerUserCase.call(
      registerRequestEntity: RegisterRequestEntity(
        firstName:
            isSocialAccount
                ? _socialAccountInfo?.firstName
                : firstNameController.text,
        lastName:
            isSocialAccount
                ? _socialAccountInfo?.lastName
                : lastNameController.text,
        email:
            isSocialAccount ? _socialAccountInfo?.email : emailController.text,
        password:
            isSocialAccount
                ? _socialAccountInfo?.password
                : passwordController.text,
        rePassword:
            isSocialAccount
                ? _socialAccountInfo?.confirmPassword
                : confirmPasswordController.text,
        gender: restOfRegisterRequest.gender,
        age: restOfRegisterRequest.age,
        weight: restOfRegisterRequest.weight,
        height: restOfRegisterRequest.height,
        goal: Goals.getGoal(
          chosenGoal: restOfRegisterRequest.goal,
          appLocalizations: getIt.get<AppLocalizations>(),
        ),
        activityLevel: Activities.getActivityLevel(
          activity: restOfRegisterRequest.activityLevel,
          appLocalizations: getIt.get<AppLocalizations>(),
        ),
      ),
    );
    switch (useCaseResult) {
      case Success<RegisterResponseEntity>():
        emit(state.copyWith(registerStatus: Status.success));
      case Error<RegisterResponseEntity>():
        emit(
          state.copyWith(
            registerStatus: Status.error,
            error: useCaseResult.error,
          ),
        );
    }
  }

  Future<bool> _googleRegister() async {
    FocusManager.instance.primaryFocus?.unfocus();
    var userGoogleAccount = await _googleSignInHandler.getUserGoogleAccount();
    if (userGoogleAccount != null) {
      var names = userGoogleAccount.displayName?.split(' ') ?? [];
      _socialAccountInfo = SocialAccountInfo(
        firstName: names.isNotEmpty ? names.first : "Unknown",
        lastName: names.length > 1 ? names.last : " ",
        email: userGoogleAccount.email,
        password: ObfuscatedPassword.getObfuscatedPassword(),
        confirmPassword: ObfuscatedPassword.getObfuscatedPassword(),
      );
      return true;
    }
    return false;
  }

  Future<bool> _facebookRegister() async {
    FocusManager.instance.primaryFocus?.unfocus();
    var userFacebookResult =
        await _facebookSignInHandler.getUserFacebookAccount();
    switch (userFacebookResult) {
      case Success<FacebookResponseModel>():
        var data = userFacebookResult.data;
        var names = data.name?.split(' ') ?? [];
        _socialAccountInfo = SocialAccountInfo(
          firstName: names.isNotEmpty ? names.first : "Unknown",
          lastName: names.length > 1 ? names.last : " ",
          email: data.email ?? "",
          password: ObfuscatedPassword.getObfuscatedPassword(),
          confirmPassword: ObfuscatedPassword.getObfuscatedPassword(),
        );
        return true;
      case Error<FacebookResponseModel>():
        emit(
          state.copyWith(
            socialRegisterStatus: Status.error,
            socialRegisterError: userFacebookResult.error,
          ),
        );
    }
    return false;
  }

  void _onAnyRegisterButtonClick() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (currentRegisterMethod == RegisterMethod.apiRegister &&
        formKey.currentState!.validate()) {
      pageViewController.jumpToPage(1);
    } else {
      bool result;
      switch (currentRegisterMethod) {
        case RegisterMethod.initial:
        case RegisterMethod.apiRegister:
          return;
        case RegisterMethod.googleRegister:
          result = await _googleRegister();
        case RegisterMethod.facebookRegister:
          result = await _facebookRegister();
        case RegisterMethod.appleRegister:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
      if (result) {
        pageViewController.jumpToPage(1);
      }
    }
  }

  void _clearControllers() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}

sealed class RegisterIntent {}

class RegisterUser extends RegisterIntent {
  final RestOfRegisterRequest restOfRegisterRequest;

  RegisterUser({required this.restOfRegisterRequest});
}

class OnAnyRegisterButtonClick extends RegisterIntent {}

class ClearControllers extends RegisterIntent {}

class RestOfRegisterRequest {
  String gender;
  num age;
  num weight;
  num height;
  String goal;
  String activityLevel;

  RestOfRegisterRequest({
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
    required this.goal,
    required this.activityLevel,
  });
}

class SocialAccountInfo {
  String firstName, lastName, email, password, confirmPassword;

  SocialAccountInfo({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
