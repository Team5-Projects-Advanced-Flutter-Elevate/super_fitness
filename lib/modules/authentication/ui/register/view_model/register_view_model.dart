import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/request/register_request_entity.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/response/register_response_entity.dart';
import 'package:super_fitness/modules/authentication/domain/use_cases/register/register_use_case.dart';
import 'package:super_fitness/modules/authentication/ui/register/view_model/register_state.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterState> {
  final RegisterUserCase _registerUserCase;

  RegisterViewModel(this._registerUserCase) : super(const RegisterState());

  TextEditingController firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmController = TextEditingController();

  FocusNode firstNameNode = FocusNode(),
      lastNameNode = FocusNode(),
      emailNode = FocusNode(),
      passwordNode = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _register() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      emit(const RegisterState(registerStatus: Status.loading));
      var useCaseResult = await _registerUserCase.call(
        registerRequestEntity: RegisterRequestEntity(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
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
  }
}

sealed class RegisterIntent {}

class RegisterUser extends RegisterIntent {}
