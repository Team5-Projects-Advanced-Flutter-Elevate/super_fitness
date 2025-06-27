import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/domain/entities/change_password/change_password_response_entity.dart';
import 'package:super_fitness/modules/home/domain/use_cases/change_password/change_password_use_case.dart';
import 'package:super_fitness/modules/home/ui/view_model/change_password/change_password_states.dart';

@injectable
class ChangePasswordViewModel extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  @factoryMethod
  ChangePasswordViewModel(this.changePasswordUseCase)
      : super(const ChangePasswordState());

  void onIntent(ChangePasswordIntent intent) {
    switch (intent) {
      case PasswordIntent():
        _changePassword(intent.password, intent.newPassword);
        break;
    }
  }

  Future<void> _changePassword(String? password, String? newPassword) async {
    emit(state.copyWith(changePasswordStatus: ChangePasswordStatus.loading));
    var result = await changePasswordUseCase.call(password!, newPassword!);
    switch (result) {
      case Success<ChangePasswordResponseEntity>():
        final updatedState = state.copyWith(
          changePasswordStatus: ChangePasswordStatus.success,
        );
        emit(updatedState.copyWith(initialData: updatedState));
        break;

      case Error<ChangePasswordResponseEntity?>():
        emit(
          state.copyWith(
            changePasswordStatus: ChangePasswordStatus.error,
            error: result.toString(),
          ),
        );
        break;
    }
  }
}

sealed class ChangePasswordIntent {}

class PasswordIntent extends ChangePasswordIntent {
  PasswordIntent(this.password, this.newPassword);
  final String password;
  final String newPassword;
}
