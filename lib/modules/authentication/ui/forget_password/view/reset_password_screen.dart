import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/colors/app_colors.dart';

import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../core/validation/validation_functions.dart';
import '../../../../../core/widgets/loading_state_widget.dart';
import '../view_model/forget_password_state.dart';
import '../view_model/forget_password_view_model.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

late TextEditingController newPasswordController;
late TextEditingController confirmPasswordController;
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _ResetPasswordScreenState
    extends BaseStatefulWidgetState<ResetPasswordScreen> {
  final ForgetPasswordViewModel resetPasswordViewModel =
      getIt.get<ForgetPasswordViewModel>();
  bool isNewPasswordObscure = true, isConfirmPasswordObscure = true;

  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
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
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: BlocProvider(
          create: (context) => resetPasswordViewModel,
          child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
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
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: screenWidth * 0.06,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              appLocalizations.resetPassDesc,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                            ),

                            child: Text(
                              appLocalizations.createNewPassword,
                              style: theme.textTheme.titleLarge,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: const EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                  color: AppColors.black.withValues(alpha: .5),

                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      validator:
                                          (value) => getIt<ValidateFunctions>()
                                              .validationOfPassword(value),

                                      controller: newPasswordController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: isNewPasswordObscure,
                                      obscuringCharacter: "*",
                                      decoration: InputDecoration(
                                        enabled: true,
                                        hintText: appLocalizations.password,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isNewPasswordObscure =
                                                  !isNewPasswordObscure;
                                            });
                                          },
                                          icon: Icon(
                                            isNewPasswordObscure
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 16.0,
                                          ),
                                          child: Icon(
                                            Icons.lock_outline_sharp,
                                            color: AppColors.black[20],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.03),
                                    TextFormField(
                                      validator:
                                          (value) => getIt<ValidateFunctions>()
                                              .validationOfConfirmPassword(
                                                value,
                                                newPasswordController.text,
                                              ),
                                      controller: confirmPasswordController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: isConfirmPasswordObscure,
                                      obscuringCharacter: "*",
                                      decoration: InputDecoration(
                                        enabled: true,
                                        hintText:
                                            appLocalizations.confirmPassword,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isConfirmPasswordObscure =
                                                  !isConfirmPasswordObscure;
                                            });
                                          },
                                          icon: Icon(
                                            isConfirmPasswordObscure
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 16.0,
                                          ),
                                          child: Icon(
                                            Icons.lock_outline_sharp,
                                            color: AppColors.black[20],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.04),
                                    state.resetPasswordStatus ==
                                            ResetPasswordStatus.loading
                                        ? const LoadingStateWidget()
                                        : Row(
                                          children: [
                                            Expanded(
                                              child: FilledButton(
                                                onPressed: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    resetPasswordViewModel
                                                        .onIntent(
                                                          ResetPasswordIntent(
                                                            newPasswordController
                                                                .text
                                                                .trim(),
                                                          ),
                                                        );
                                                  }
                                                },

                                                child:
                                                    state.resetPasswordStatus ==
                                                            ResetPasswordStatus
                                                                .loading
                                                        ? CircularProgressIndicator(
                                                          color:
                                                              AppColors.white,
                                                        )
                                                        : Text(
                                                          appLocalizations.done,
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
                        ],
                      ),
                    ),
                  ),
                ),
            listener: (context, state) {
              if (state.resetPasswordStatus == ResetPasswordStatus.success) {
                displaySnackBar(
                  contentType: ContentType.success,
                  title: appLocalizations.success,
                  message: appLocalizations.yourPasswordChanged,
                );
                //Navigator.pushNamedAndRemoveUntil(context, DefinedRoutes.loginScreenRoute, (_) => false);
              } else if (state.resetPasswordStatus ==
                  ResetPasswordStatus.error) {
                displaySnackBar(
                  contentType: ContentType.failure,
                  title: appLocalizations.error,
                  message: state.error,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
