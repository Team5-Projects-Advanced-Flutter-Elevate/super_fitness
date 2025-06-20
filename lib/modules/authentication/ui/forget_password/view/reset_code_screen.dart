import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
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
              child: ClipRRect(
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
                          //controller: widget.viewModel.otpController,
                          length: 6,
                          width: screenWidth,
                          otpFieldStyle: OtpFieldStyle(
                            focusBorderColor: AppColors.white,
                            errorBorderColor: AppColors.white,
                            enabledBorderColor: AppColors.mainColorDark,
                          ),
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: AppColors.mainColorDark,
                          ),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.underline,
                          //hasError: _hasError,
                          onChanged: (value) {},
                          onCompleted: (code) {
                            widget.viewModel.otpCode = code;
                          },
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                onPressed: () {
                                  widget.viewModel.onIntent(ResetCodeIntent());
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
                        InkWell(
                          onTap: () {
                            widget.viewModel.onIntent(ResetCodeIntent());
                          },
                          child: Text(
                            appLocalizations.resend,
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: AppColors.mainColorDark,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.mainColorDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
