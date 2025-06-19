import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/utilities/activities/activities.dart';
import 'package:super_fitness/core/utilities/google_sign_in/google_sign_in_handler.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/request/register_request_entity.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/response/register_response_entity.dart';
import 'package:super_fitness/modules/authentication/domain/use_cases/firebase_auth/google/sign_up/sign_up_with_google_account.dart';
import 'package:super_fitness/modules/authentication/domain/use_cases/register/register_use_case.dart';
import 'package:super_fitness/modules/authentication/ui/register/view_model/register_state.dart';

import '../../../data/models/user/user_dto.dart';

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
  final SignUpWithGoogleAccountUseCase _signUpWithGoogleAccountUseCase;

  final GoogleSignInHandler _googleSignInHandler;

  RegisterViewModel(this._registerUserCase,
      this._signUpWithGoogleAccountUseCase,
      this._googleSignInHandler,) : super(const RegisterState());

  TextEditingController firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmController = TextEditingController();

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
        _register(restOfRegisterRequest: intent.restOfRegisterRequest);
        break;
      case OnAnyRegisterButtonClick():
        _onAnyRegisterButtonClick();
        break;
    }
  }

  void _register({required RestOfRegisterRequest restOfRegisterRequest}) {
    switch (currentRegisterMethod) {
      case RegisterMethod.initial:
        break;
      case RegisterMethod.apiRegister:
        _apiRegister(restOfRegisterRequest: restOfRegisterRequest);
      case RegisterMethod.googleRegister:
        _googleRegister(restOfRegisterRequest: restOfRegisterRequest);
      case RegisterMethod.facebookRegister:
      // TODO: Handle this case.
        throw UnimplementedError();
      case RegisterMethod.appleRegister:
      // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  void _apiRegister({
    required RestOfRegisterRequest restOfRegisterRequest,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(const RegisterState(registerStatus: Status.loading));
    var useCaseResult = await _registerUserCase.call(
      registerRequestEntity: RegisterRequestEntity(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
        rePassword: confirmController.text,
        gender: restOfRegisterRequest.gender,
        age: restOfRegisterRequest.age,
        weight: restOfRegisterRequest.weight,
        height: restOfRegisterRequest.height,
        goal: restOfRegisterRequest.goal,
        activityLevel: Activities.getActivityLevel(
          restOfRegisterRequest.activityLevel,
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

  void _googleRegister({
    required RestOfRegisterRequest restOfRegisterRequest,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(const RegisterState(registerStatus: Status.loading));
    var googleUserAccount = await _googleSignInHandler.getUserGoogleAccount();
    if (googleUserAccount == null) {
      emit(const RegisterState(registerStatus: Status.idle));
      return;
    }
    List<String> names = [];
    names = googleUserAccount.displayName?.split(' ') ?? [];
    var useCaseResult = await _signUpWithGoogleAccountUseCase.call(
      googleUserAccount,
      UserDto(
        id: googleUserAccount.id,
        firstName: names.length > 2 ? names[0] : "",
        lastName: names.length > 2 ? names[1] : "",
        email: googleUserAccount.email,
        gender: restOfRegisterRequest.gender,
        age: restOfRegisterRequest.age,
        weight: restOfRegisterRequest.weight,
        height: restOfRegisterRequest.height,
        goal: restOfRegisterRequest.goal,
        activityLevel: Activities.getActivityLevel(
          restOfRegisterRequest.activityLevel,
        ),
      ),
    );
    switch (useCaseResult) {
      case Success<UserCredential>():
        emit(state.copyWith(registerStatus: Status.success));
      case Error<UserCredential>():
        emit(
          state.copyWith(
            registerStatus: Status.error,
            error: useCaseResult.error,
          ),
        );
    }
  }

  void _onAnyRegisterButtonClick() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate() &&
        currentRegisterMethod == RegisterMethod.apiRegister) {
      pageViewController.jumpToPage(1);
    } else {
      pageViewController.jumpToPage(1);
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
