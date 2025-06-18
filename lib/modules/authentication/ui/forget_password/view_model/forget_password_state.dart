sealed class PasswordState {}

class PasswordInitialState extends PasswordState {}

class PasswordLoadingState extends PasswordState {}

class PasswordErrorState extends PasswordState {
  final Object error;
  PasswordErrorState(this.error);
}

class PasswordSuccessState extends PasswordState {}

///////////////////////////////////Email-State/////////////
sealed class EmailState {}

class EmailInitialState extends EmailState {}

class EmailLoadingState extends EmailState {}

class EmailErrorState extends EmailState {
  final Object error;
  EmailErrorState(this.error);
}

class EmailSuccessState extends EmailState {}

////////////////////////////////////OTP-State/////////////
sealed class OtpState {}

class OtpInitialState extends OtpState {}

class OtpLoadingState extends OtpState {}

class OtpErrorState extends OtpState {
  final Object error;
  OtpErrorState(this.error);
}

class OtpSuccessState extends OtpState {}
