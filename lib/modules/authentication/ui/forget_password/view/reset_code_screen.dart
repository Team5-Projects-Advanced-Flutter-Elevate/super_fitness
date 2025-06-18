import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:super_fitness/modules/authentication/ui/forget_password/view/reset_password_screen.dart';

import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../core/widgets/loading_state_widget.dart';
import '../../../../../core/widgets/timer.dart';
import '../view_model/email_view_model.dart';
import '../view_model/forget_password_state.dart';
import '../view_model/reset_code_view_model.dart';

class ResetCodeScreen extends StatefulWidget {
  const ResetCodeScreen({super.key, required this.email});

  final String email;

  @override
  State<ResetCodeScreen> createState() => _ResetCodeScreenState();
}

class _ResetCodeScreenState extends BaseStatefulWidgetState<ResetCodeScreen> {
  bool sent = true;
  bool resend = false;
  bool _hasError = false;
  final ValueNotifier<bool> _isLessThan5Minutes = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();
  ResetCodeViewModel resetCodeViewModel = getIt.get<ResetCodeViewModel>();
  EmailViewModel emailViewModel = getIt.get<EmailViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => resetCodeViewModel,
      child: BlocConsumer<ResetCodeViewModel, OtpState>(
        builder:
            (context, state) => Scaffold(
              appBar: AppBar(
                forceMaterialTransparency: true,
                automaticallyImplyLeading: false,
                titleSpacing: 0.0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios, size: screenWidth * 0.06),
                ),
                title: Text(
                  appLocalizations.password,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      Text(
                        appLocalizations.otpScreenTitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        appLocalizations.otpScreenDescription,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Center(
                        child:
                            state is OtpLoadingState
                                ? loadingDialog()
                                : OTPTextField(
                                  length: 6,
                                  width: screenWidth * 0.75,
                                  otpFieldStyle: OtpFieldStyle(
                                    errorBorderColor: Colors.red,
                                  ),
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.0425,
                                  ),
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceAround,
                                  fieldStyle: FieldStyle.box,
                                  hasError: _hasError,
                                  onChanged: (value) {
                                    if (_hasError) {
                                      setState(() {
                                        _hasError =
                                            false; // Reset error once user starts editing
                                      });
                                    }
                                  },
                                  onCompleted: (code) {
                                    resetCodeViewModel.onIntent(
                                      ResetCodeIntent(code),
                                    );
                                  },
                                ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            appLocalizations.didnotReciveOtp,
                            style: theme.textTheme.bodyLarge,
                          ),
                          resend == false
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Timer(
                                    isLessThan5Minutes: _isLessThan5Minutes,
                                    examDuration: 30,
                                    onTimeEnd: () {
                                      setState(() {
                                        resend = true;
                                      });
                                    },
                                  ),
                                ],
                              )
                              : InkWell(
                                onTap: () {
                                  emailViewModel.onIntent(
                                    ForgotPasswordIntent(widget.email),
                                  );
                                },
                                child: Text(
                                  appLocalizations.resend,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.mainColorDark,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.mainColorDark,
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        listener: (context, state) {
          if (state is OtpSuccessState) {
            alert('otpSuccess', '');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResetPasswordScreen(),
              ),
            );
          } else if (state is OtpErrorState) {
            setState(() {
              _hasError = true;
            });
            alert('failed', state.toString());
          } else if (state is OtpLoadingState) {
            loadingDialog();
          } else if (state is EmailSuccessState) {
            setState(() {
              resend = false;
            });
            alert('success', '');
          } else if (state is EmailErrorState) {
            alert('failed', state.toString());
          }
        },
      ),
    );
  }

  Future<void> alert(final String type, final String msg) {
    if (type == 'success') {
      return displaySnackBar(
        contentType: ContentType.success,
        title: appLocalizations.success,
        message: appLocalizations.codeSendTitle,
      );
    } else if (type == 'otpSuccess') {
      return displaySnackBar(
        contentType: ContentType.success,
        title: appLocalizations.success,
        message: appLocalizations.codeValid,
      );
    } else {
      return displaySnackBar(
        contentType: ContentType.failure,
        title: appLocalizations.error,
        message: msg,
      );
    }
  }

  Widget loadingDialog() {
    return const LoadingStateWidget();
  }
}
