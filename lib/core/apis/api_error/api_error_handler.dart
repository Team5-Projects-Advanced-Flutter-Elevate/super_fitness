import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/utilities/custom_exceptions/firebase_auth_register_exception.dart';
import 'package:super_fitness/core/utilities/custom_exceptions/firebase_auth_sign_in_exception.dart';
import '../../../../shared_layers/localization/generated/app_localizations.dart';
import 'api_error_model.dart';

@lazySingleton
class ApiErrorHandler {
  AppLocalizations _appLocalizations;

  set appLocalizations(AppLocalizations appLocalization) {
    _appLocalizations = appLocalization;
  }

  ApiErrorHandler(this._appLocalizations);

  String handle(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return _appLocalizations.connectionTimeout;
        case DioExceptionType.sendTimeout:
          return _appLocalizations.sendTimeout;
        case DioExceptionType.receiveTimeout:
          return _appLocalizations.receiveTimeout;
        case DioExceptionType.badResponse:
          return ApiErrorModel.fromJson(error.response?.data).error ??
              _appLocalizations.somethingWentWrong;
        case DioExceptionType.cancel:
          return _appLocalizations.cancel;
        case DioExceptionType.connectionError:
          return _appLocalizations.connectionError;
        case DioExceptionType.unknown:
          return _appLocalizations.unknownError;
        case DioExceptionType.badCertificate:
          return _appLocalizations.badCertificate;
      }
    } else if (error is FirebaseAuthRegisterException) {
      return error.toString();
    } else if (error is FirebaseAuthSignInException) {
      return error.toString();
    } else {
      return error.toString();
    }
  }
}
