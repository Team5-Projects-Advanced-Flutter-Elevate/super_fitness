import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/authentication/domain/usecase/login/login_local.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/domain/use_cases/get_profile_data.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getProfileDataUseCase, this._storeLoginLocalUseCase)
    : super(const ProfileState());
  final GetProfileDataUseCase _getProfileDataUseCase;
  final StoreLoginLocalUseCase _storeLoginLocalUseCase;

  void doIntent(ProfileIntent intent) async {
    switch (intent) {
      case GetProfileDataIntent():
        _getProfileData();
      case LogoutIntent():
        _logout();
    }
  }

  Future<void> _getProfileData() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    var result = await _getProfileDataUseCase.execute();
    switch (result) {
      case Success<UserEntity?>():
        emit(
          state.copyWith(
            status: ProfileStatus.success,
            userEntity: result.data,
          ),
        );
      case Error<UserEntity?>():
        emit(
          state.copyWith(
            status: ProfileStatus.error,
            getProfileError: result.error,
          ),
        );
    }
  }

  void _logout() => _storeLoginLocalUseCase.clear();
}

sealed class ProfileIntent {}

class GetProfileDataIntent extends ProfileIntent {}

class LogoutIntent extends ProfileIntent {}
