import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/apis/api_result/api_result.dart';
import '../../../data/models/forget_password/forget_password_response.dart';
import '../../../domain/use_cases/forget_password/forget_password_use_case.dart';
import 'forget_password_state.dart';

@injectable
class EmailViewModel extends Cubit<EmailState> {
  ForgetPasswordUseCase forgetPasswordUseCase;

  @factoryMethod
  EmailViewModel(this.forgetPasswordUseCase) : super(EmailInitialState());

  void onIntent(EmailIntent intent) {
    switch (intent) {
      case ForgotPasswordIntent():
        _forgetPasswordHandling(intent.email);
        break;
    }
  }

  _forgetPasswordHandling(String email) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(EmailLoadingState());
    var result = await forgetPasswordUseCase.call(email);
    switch (result) {
      case Success<ForgetPasswordResponse?>():
        emit(EmailSuccessState());

      case Error<ForgetPasswordResponse?>():
        emit(EmailErrorState(result.error));
    }
  }
}

sealed class EmailIntent {}

class ForgotPasswordIntent extends EmailIntent {
  final String email;

  ForgotPasswordIntent(this.email);
}
