import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/obfuscation/password/obfuscated_password.dart';
import 'package:super_fitness/core/utilities/activities/activities.dart';
import 'package:super_fitness/core/utilities/goals/goals.dart';
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

  RegisterViewModel(this._registerUserCase, this._googleSignInHandler)
    : super(const RegisterState());

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

  void doIntent(RegisterIntent intent) {
    switch (intent) {
      case RegisterUser():
        _apiRegister(restOfRegisterRequest: intent.restOfRegisterRequest);
        break;
      case OnAnyRegisterButtonClick():
        _onAnyRegisterButtonClick();
        break;
    }
  }

  void _apiRegister({
    required RestOfRegisterRequest restOfRegisterRequest,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(const RegisterState(registerStatus: Status.loading));
    print("<<<<<<< ${emailController.text}");
    var useCaseResult = await _registerUserCase.call(
      registerRequestEntity: RegisterRequestEntity(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
        rePassword: confirmPasswordController.text,
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
      firstNameController.text = names.isNotEmpty ? names.first : "Unknown";
      lastNameController.text = names.length > 1 ? names.last : " ";
      emailController.text = userGoogleAccount.email;
      passwordController.text = ObfuscatedPassword.getObfuscatedPassword();
      confirmPasswordController.text =
          ObfuscatedPassword.getObfuscatedPassword();
      print("--------- ${passwordController.text}");
      return true;
    }
    return false;
  }

  void _onAnyRegisterButtonClick() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (currentRegisterMethod == RegisterMethod.apiRegister &&
        formKey.currentState!.validate()) {
      pageViewController.jumpToPage(1);
    } else if (currentRegisterMethod == RegisterMethod.googleRegister) {
      var result = await _googleRegister();
      if (result) {
        pageViewController.jumpToPage(1);
      } else {
        return;
      }
    }
  }
}

sealed class RegisterIntent {}

class RegisterUser extends RegisterIntent {
  final RestOfRegisterRequest restOfRegisterRequest;

  RegisterUser({required this.restOfRegisterRequest});
}

class OnAnyRegisterButtonClick extends RegisterIntent {}

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
