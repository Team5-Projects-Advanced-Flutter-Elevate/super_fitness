import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../core/validation/validation_functions.dart';
import '../../../../../core/widgets/loading_state_widget.dart';
import '../view_model/forget_password_state.dart';
import '../view_model/reset_password_screen_view_model.dart';
import 'forget_password_screen.dart';

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
  final ResetPasswordViewModel resetPasswordViewModel =
      getIt.get<ResetPasswordViewModel>();
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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocProvider(
        create: (context) => resetPasswordViewModel,
        child: BlocConsumer<ResetPasswordViewModel, PasswordState>(
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
                    style: theme.textTheme.headlineMedium,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: screenHeight * 0.05),
                          Text(
                            appLocalizations.resetPasswordScreenTitle,
                            style: theme.textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            appLocalizations.resetPasswordScreenDescription,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: screenHeight * 0.04),
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
                              hintText: appLocalizations.enterPassword,
                              labelText: appLocalizations.newPassword,
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
                              hintText: appLocalizations.confirmNewPassword,
                              labelText: appLocalizations.confirmNewPassword,
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
                          ),
                          SizedBox(height: screenHeight * 0.06),
                          state is PasswordLoadingState
                              ? loadingAlert()
                              : ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    resetPasswordViewModel.onIntent(
                                      ResetPasswordIntent(
                                        emailController.text,
                                        newPasswordController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  padding: WidgetStatePropertyAll(
                                    EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.018,
                                    ),
                                  ),
                                ),
                                child: Text(appLocalizations.confirm),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          listener: (context, state) {
            if (state is PasswordSuccessState) {
              alert('success', '');
            } else if (state is PasswordErrorState) {
              alert('failed', state.error.toString());
            }
          },
        ),
      ),
    );
  }

  Future<void> alert(final String type, final String msg) {
    if (type == 'success') {
      return displaySnackBar(
        contentType: ContentType.success,
        title: appLocalizations.success,
        message: appLocalizations.yourPasswordChanged,
      );
    } else {
      return displaySnackBar(
        contentType: ContentType.failure,
        title: appLocalizations.error,
        message: msg,
      );
    }
  }

  Widget loadingAlert() {
    return const LoadingStateWidget();
  }
}
