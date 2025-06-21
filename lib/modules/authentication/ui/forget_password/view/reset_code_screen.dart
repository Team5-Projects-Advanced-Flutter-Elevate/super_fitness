import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/authentication/ui/forget_password/view/reset_password_screen.dart';
import 'package:super_fitness/modules/authentication/ui/forget_password/view_model/forget_password_state.dart';
import 'package:super_fitness/modules/authentication/ui/forget_password/view_model/forget_password_view_model.dart';

import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/constants/assets_paths/assets_paths.dart';

class ResetCodeScreen extends StatefulWidget {
  const ResetCodeScreen({super.key, required this.viewModel});
  final ForgetPasswordViewModel viewModel;
  @override
  State<ResetCodeScreen> createState() => _ResetCodeScreenState();
}

class _ResetCodeScreenState extends BaseStatefulWidgetState<ResetCodeScreen> {
  @override
  void initState() {
    widget.viewModel.onIntent(StartTimerIntent());
    super.initState();
  }

  @override
  void dispose() {
    widget.viewModel.onIntent(DisposeTimerAndValueNotifierIntent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(AssetsPaths.appIcon)],
            ),
            SizedBox(height: screenHeight * 0.1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),

              child: Text(
                appLocalizations.oTpCode,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),

              child: Text(
                appLocalizations.enterOtpCode,
                style: theme.textTheme.bodyLarge,
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            BlocProvider(
              create: (context) => widget.viewModel,
              child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
                listener: (context, state) {
                  if (state.sendOtpStatus == SendOtpStatus.success) {
                    displaySnackBar(
                      contentType: ContentType.success,
                      title: appLocalizations.success,
                      message: appLocalizations.successEmailVerified,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ResetPasswordScreen(
                              viewModel: widget.viewModel,
                            ),
                      ),
                    );
                  }
                  if (state.sendEmailStatus == SendEmailStatus.success) {
                    displaySnackBar(
                      contentType: ContentType.success,
                      title: appLocalizations.success,
                      message: appLocalizations.codeSendTitle,
                    );
                  } else if (state.sendEmailStatus == SendEmailStatus.error ||
                      state.sendOtpStatus == SendOtpStatus.error) {
                    displaySnackBar(
                      contentType: ContentType.failure,
                      title: appLocalizations.error,
                      message: state.error,
                    );
                  }
                },
                builder: (BuildContext context, ForgetPasswordState state) {
                  return ClipRRect(
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
                            OTPTextField(
                              controller: widget.viewModel.otpFieldController,
                              length: 6,
                              width: screenWidth,
                              otpFieldStyle: OtpFieldStyle(
                                focusBorderColor: AppColors.white,
                                errorBorderColor: AppColors.white,
                                disabledBorderColor: AppColors.white,

                                enabledBorderColor: AppColors.mainColorDark,
                              ),
                              style: theme.textTheme.titleLarge!.copyWith(
                                color: AppColors.mainColorDark,
                              ),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.underline,
                              hasError:
                                  state.sendOtpStatus == SendOtpStatus.error,
                              onChanged: (value) {},
                              onCompleted: (code) {
                                setState(() {});
                                widget.viewModel.otpCode = code;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                state.sendOtpStatus == SendOtpStatus.loading
                                    ? const LoadingStateWidget()
                                    : Expanded(
                                      child: FilledButton(
                                        onPressed:
                                            widget.viewModel.otpCode == null
                                                ? null
                                                : () {
                                                  widget.viewModel.onIntent(
                                                    ResetCodeIntent(),
                                                  );
                                                },
                                        child: Text(appLocalizations.confirm),
                                      ),
                                    ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              appLocalizations.didnotReciveOtp,
                              style: theme.textTheme.bodyLarge,
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            ValueListenableBuilder<int>(
                              valueListenable: widget.viewModel.timeRemaining,
                              builder: (context, value, child) {
                                return value >= 1
                                    ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.timer, size: 25),
                                        const SizedBox(width: 10),
                                        Text(
                                          value > 9
                                              ? "00:$value"
                                              : "00:0$value",
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(
                                                color: AppColors.mainColorDark,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    )
                                    : state.sendEmailStatus ==
                                        SendEmailStatus.loading
                                    ? const SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: LoadingStateWidget(),
                                    )
                                    : InkWell(
                                      onTap: () {
                                        widget.viewModel.onIntent(
                                          ForgotPasswordIntent(),
                                        );
                                      },
                                      child: Text(
                                        appLocalizations.resend,
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(
                                              color: AppColors.mainColorDark,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  AppColors.mainColorDark,
                                            ),
                                      ),
                                    );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
