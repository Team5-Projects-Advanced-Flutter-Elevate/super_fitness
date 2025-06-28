import 'dart:ui';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/home/ui/view_model/change_password/change_password_states.dart';
import 'package:super_fitness/modules/home/ui/view_model/change_password/change_password_view_model.dart';
import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../core/validation/validation_functions.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends BaseStatefulWidgetState<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ChangePasswordViewModel changePasswordViewModel =
      getIt.get<ChangePasswordViewModel>();
  bool isEnabled = false;

  bool isCurrentPasswordObscure = true,
      isNewPasswordObscure = true,
      isConfirmPasswordObscure = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPaths.homeBg),
          fit: BoxFit.cover,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
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
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
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

                  BlocConsumer<ChangePasswordViewModel, ChangePasswordState>(
                    bloc: changePasswordViewModel,
                    listener: (context, state) {
                      if (state.changePasswordStatus ==
                          ChangePasswordStatus.success) {
                        displaySnackBar(
                          contentType: ContentType.success,
                          title: appLocalizations.success,
                          message: appLocalizations.yourPasswordChanged,
                        );
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          DefinedRoutes.loginScreenRoute,
                          (route) => false,
                        );
                      } else if (state.changePasswordStatus ==
                          ChangePasswordStatus.error) {
                        displaySnackBar(
                          contentType: ContentType.failure,
                          title: appLocalizations.error,
                          message: state.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.07),
                            decoration: BoxDecoration(
                              color: AppColors.black.withValues(alpha: .5),

                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  enabled: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _currentPasswordController,
                                  obscureText: isCurrentPasswordObscure,
                                  obscuringCharacter: '*',
                                  decoration: InputDecoration(
                                    hintText: appLocalizations.password,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(
                                        left: screenWidth * 0.016,
                                      ),
                                      child: Icon(
                                        Icons.lock_outline_sharp,
                                        color: AppColors.black[20],
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isCurrentPasswordObscure =
                                              !isCurrentPasswordObscure;
                                        });
                                      },
                                      icon: Icon(
                                        isCurrentPasswordObscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                  ),
                                  validator:
                                      (value) => getIt<ValidateFunctions>()
                                          .validationOfPassword(value),
                                ),
                                SizedBox(height: screenHeight * 0.03),

                                TextFormField(
                                  controller: _newPasswordController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: isNewPasswordObscure,
                                  obscuringCharacter: '*',
                                  decoration: InputDecoration(
                                    enabled: true,
                                    hintText: appLocalizations.newPassword,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(
                                        left: screenWidth * 0.016,
                                      ),
                                      child: Icon(
                                        Icons.lock_outline_sharp,
                                        color: AppColors.black[20],
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isNewPasswordObscure =
                                              !isNewPasswordObscure;
                                        });
                                      },
                                      icon: Icon(
                                        isNewPasswordObscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                  ),
                                  validator:
                                      (value) => getIt<ValidateFunctions>()
                                          .validationOfPassword(value),
                                ),
                                SizedBox(height: screenHeight * 0.03),

                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _confirmPasswordController,
                                  obscureText: isConfirmPasswordObscure,
                                  obscuringCharacter: '*',
                                  decoration: InputDecoration(
                                    enabled: true,
                                    hintText: appLocalizations.confirmPassword,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(
                                        left: screenWidth * 0.016,
                                      ),
                                      child: Icon(
                                        Icons.lock_outline_sharp,
                                        color: AppColors.black[20],
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isConfirmPasswordObscure =
                                              !isConfirmPasswordObscure;
                                        });
                                      },
                                      icon: Icon(
                                        isConfirmPasswordObscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                  ),
                                  validator:
                                      (value) => getIt<ValidateFunctions>()
                                          .validationOfConfirmPassword(
                                            value,
                                            _newPasswordController.text,
                                          ),
                                ),
                                SizedBox(height: screenHeight * 0.08),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    state.changePasswordStatus ==
                                            ChangePasswordStatus.loading
                                        ? const LoadingStateWidget()
                                        : Expanded(
                                          child: FilledButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                changePasswordViewModel.onIntent(
                                                  PasswordIntent(
                                                    _currentPasswordController
                                                        .text
                                                        .trim(),
                                                    _newPasswordController.text
                                                        .trim(),
                                                  ),
                                                );
                                              }
                                            },

                                            child: Text(appLocalizations.done),
                                          ),
                                        ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
