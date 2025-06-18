import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:super_fitness/modules/authentication/ui/forget_password/view/reset_password_screen.dart';

import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../core/widgets/loading_state_widget.dart';
import '../../../../../core/widgets/timer.dart';
import '../view_model/email_view_model.dart';
import '../view_model/forget_password_state.dart';
import '../view_model/reset_code_view_model.dart';

class ResetCodeScreen extends StatefulWidget {
  const ResetCodeScreen({super.key, this.email});

  final String? email;

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
  OtpFieldController otpController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => resetCodeViewModel,
      child: BlocConsumer<ResetCodeViewModel, OtpState>(
        builder:
            (context, state) => Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsPaths.authBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
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
                ),
                body: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image.asset(AssetsPaths.appIcon)],
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                        ),

                        child: Text(
                          appLocalizations.forgetPassword,
                          style: theme.textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                        ),

                        child: Text(
                          appLocalizations.pleaseEnterEmail,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: AppColors.black.withValues(alpha: .5),

                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child:
                                      state is OtpLoadingState
                                          ? const LoadingStateWidget()
                                          : OTPTextField(
                                            controller: otpController,
                                            length: 6,
                                            width: screenWidth,
                                            fieldWidth: screenWidth * 0.12,
                                            otpFieldStyle: OtpFieldStyle(
                                              disabledBorderColor:
                                                  AppColors.mainColorDark,
                                              errorBorderColor: Colors.red,
                                              enabledBorderColor:
                                                  AppColors.mainColorDark,
                                              focusBorderColor: AppColors.white
                                                  .withValues(alpha: .4),
                                              borderColor: AppColors.black[90]!,
                                            ),
                                            style: TextStyle(
                                              color: AppColors.mainColorDark,
                                              fontSize: screenWidth * 0.042,
                                            ),
                                            textFieldAlignment:
                                                MainAxisAlignment.spaceAround,
                                            fieldStyle: FieldStyle.underline,
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
                                              // print(otpController.);
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
                                    Column(
                                      children: [
                                        Text(
                                          appLocalizations.didnotReciveOtp,
                                          style: theme.textTheme.bodyLarge,
                                        ),
                                        resend == false
                                            ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Timer(
                                                  isLessThan5Minutes:
                                                      _isLessThan5Minutes,
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
                                                  ForgotPasswordIntent(
                                                    widget.email!,
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                appLocalizations.resend,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodyLarge?.copyWith(
                                                  color:
                                                      AppColors.mainColorDark,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      AppColors.mainColorDark,

                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
            const LoadingStateWidget();
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
}
