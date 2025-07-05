import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/edit_profile/ui/cubit/states.dart';
import '../../../../core/apis/api_result/api_result.dart';
import '../../../../core/di/injectable_initializer.dart';
import '../../../../core/utilities/user_provider/user_provider.dart';
import '../../../authentication/domain/entities/login/login_data_response_entity.dart';
import '../../../authentication/domain/usecase/login/login_local.dart';
import '../../domain/entity/edit_info.dart';
import '../../domain/entity/get_data_entity.dart';
import '../../domain/entity/upload_image_response_entity.dart';
import '../../domain/usecase/edit_info_usecase.dart';
import '../../domain/usecase/get_data_usecase.dart';
import '../../domain/usecase/upload_image.dart';

@injectable
class EditProfileViewModel extends Cubit<ProfileState> {
  final GetUserDataUseCase getLoggedUserDataUseCase;
  final EditInfoUseCase editInfoUseCase;
  final UploadImageUseCase uploadImageUseCase;

  @factoryMethod
  EditProfileViewModel(
    this.getLoggedUserDataUseCase,
    this.editInfoUseCase,
    this.uploadImageUseCase,
  ) : super(const ProfileState());

  void onIntent(EditIntent intent) {
    switch (intent) {
      case EditProfileIntent():
        _getLogedData();
        break;

      case EditInfo():
        _editInfo(
          intent.firstName,
          intent.lastName,
          intent.email,
          intent.goal,
          intent.weight,
          intent.level,
        );
        break;

      case LoadProfileImageIntent():
        _uploadProfileImage(intent.imageFile);
        break;
    }
  }

  Future<void> _getLogedData() async {
    emit(state.copyWith(getProfileDataStatus: EditProfileStatus.loading));

    var result = await getLoggedUserDataUseCase.call();

    switch (result) {
      case Success<GetDataEntity>():
        final data = result.data.user;

        // Build a new state with fetched data
        final updatedState = state.copyWith(
          getProfileDataStatus: EditProfileStatus.success,
          firstName: data?.firstName ?? '',
          lastName: data?.lastName ?? '',
          email: data?.email ?? '',
          password: 'Mmmmm@123',
          // Default for UI placeholder only
          profilePhotoLink: data?.photo,
          gender: data?.gender,
          goal: data?.goal,
          weight: data?.weight.toString(),
          level: data?.activityLevel,
        );

        // Save a snapshot of initial data for dirty-checking
        emit(updatedState.copyWith(initialData: updatedState));
        break;

      case Error<GetDataEntity?>():
        emit(
          state.copyWith(
            getProfileDataStatus: EditProfileStatus.error,
            error: result.toString(),
          ),
        );
        break;
    }
  }

  void _uploadProfileImage(File imageFile) async {
    emit(state.copyWith(uploadImageStatus: EditProfileStatus.loading));
    var result = await uploadImageUseCase.execute(imageFile: imageFile);
    switch (result) {
      case Success<UploadImageResponseEntity?>():
        final updatedState = state.copyWith(
          uploadImageStatus: EditProfileStatus.success,
          profilePhotoLink: imageFile.path,
        );
        emit(updatedState.copyWith(initialData: updatedState));
        final loginInfo = getIt<UserProvider>().userLoginInfo!.copyWith(
          user: getIt<UserProvider>().userLoginInfo?.user!.copyWith(
            photo: imageFile.path,
          ),
        );
        getIt.get<StoreLoginLocalUseCase>().call(loginInfo);
        getIt.get<UserProvider>().changeUserLoginInfo(loginInfo);

        break;

      case Error<UploadImageResponseEntity?>():
        emit(
          state.copyWith(
            getProfileDataStatus: EditProfileStatus.error,
            error: result.toString(),
          ),
        );
        break;
    }
  }

  Future<void> _editInfo(
    String? firstName,
    String? lastName,
    String? email,
    String? goal,
    String? weight,
    String? level,
  ) async {
    emit(state.copyWith(updateProfileStatus: EditProfileStatus.loading));

    var result = await editInfoUseCase.call(
      firstName,
      lastName,
      email,
      goal,
      weight,
      level,
    );

    switch (result) {
      case Success<EditMyInfoEntity>():
        final data = result.data.user;

        final updatedState = state.copyWith(
          updateProfileStatus: EditProfileStatus.success,
          firstName: data?.firstName ?? '',
          lastName: data?.lastName ?? '',
          email: data?.email ?? '',
          password: 'Mmmmm@123',
          // UI-only placeholder
          profilePhotoLink: data?.photo,
          goal: data?.goal ?? '',
          weight: data?.weight.toString() ?? '',
          level: data?.activityLevel ?? '',
        );

        // After successful update, reset initial snapshot
        emit(updatedState.copyWith(initialData: updatedState));

        final loginInfo = getIt<UserProvider>().userLoginInfo!.copyWith(
          user: getIt<UserProvider>().userLoginInfo?.user!.copyWith(
            firstName: data?.firstName ?? '',
            lastName: data?.lastName ?? '',
            email: data?.email ?? '',
            goal: data?.goal ?? '',
            weight: data?.weight,
            activityLevel: data?.activityLevel ?? '',
          ),
        );
        getIt.get<StoreLoginLocalUseCase>().call(loginInfo);
        getIt.get<UserProvider>().changeUserLoginInfo(loginInfo);
        break;

      case Error<EditMyInfoEntity?>():
        emit(
          state.copyWith(
            updateProfileStatus: EditProfileStatus.error,
            error: result.toString(),
          ),
        );
        break;
    }
  }
}

sealed class EditIntent {}

class EditProfileIntent extends EditIntent {}

class EditInfo extends EditIntent {
  final String firstName;
  final String? lastName;
  final String? email;
  final String? goal;
  final String? weight;
  final String? level;

  EditInfo(
    this.firstName,
    this.lastName,
    this.email,
    this.goal,
    this.weight,
    this.level,
  );
}

class LoadProfileImageIntent extends EditIntent {
  final File imageFile;

  LoadProfileImageIntent(this.imageFile);
}
