import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/apis/api_result/api_result.dart';
import '../../../data/models/forget_password/forget_password_response.dart';
import '../../../domain/use_cases/forget_password/reset_code_use_case.dart';
import 'forget_password_state.dart';

@injectable
class ResetCodeViewModel extends Cubit<OtpState> {
  ResetCodeUseCase resetCodeUseCase;

  @factoryMethod
  ResetCodeViewModel(this.resetCodeUseCase) : super(OtpInitialState());

  void onIntent(OtpIntent intent) {
    switch (intent) {
      case ResetCodeIntent():
        _resetCodeHandling(intent.code);
        break;
    }
  }

  _resetCodeHandling(String code) async {
    emit(OtpLoadingState());
    var result = await resetCodeUseCase.call(code);
    switch (result) {
      case Success<ForgetPasswordResponse?>():
        emit(OtpSuccessState());
      case Error<ForgetPasswordResponse?>():
        emit(OtpErrorState(result.error));
    }
  }
}

sealed class OtpIntent {}

class ResetCodeIntent extends OtpIntent {
  final String code;

  ResetCodeIntent(this.code);
}
