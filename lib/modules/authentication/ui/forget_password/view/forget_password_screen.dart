import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/modules/authentication/ui/forget_password/view/reset_code_screen.dart';

import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../core/validation/validation_functions.dart';
import '../../../../../core/widgets/loading_state_widget.dart';
import '../view_model/forget_password_state.dart';
import '../view_model/forget_password_view_model.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

late TextEditingController emailController;

class _ForgetPasswordScreenState
    extends BaseStatefulWidgetState<ForgetPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ForgetPasswordViewModel viewModel = getIt.get<ForgetPasswordViewModel>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPaths.authBg),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
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
            body: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset(AssetsPaths.appIcon)],
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                    ),

                    child: Text(
                      appLocalizations.pleaseEnterEmail,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
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

                  SizedBox(height: screenHeight * 0.02),

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
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator:
                                  (value) => getIt<ValidateFunctions>()
                                      .validationOfEmail(value),

                              controller: emailController,
                              decoration: InputDecoration(
                                enabled: true,
                                hintText: appLocalizations.email,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.0,
                                    right: 5,
                                  ),
                                  child: Icon(Icons.mail_outline),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.025),
                            BlocConsumer<
                              ForgetPasswordViewModel,
                              ForgetPasswordState
                            >(
                              builder: (context, state) {
                                if (state.sendEmailStatus ==
                                    SendEmailStatus.loading) {
                                  return const LoadingStateWidget();
                                }
                                return Row(
                                  children: [
                                    Expanded(
                                      child: FilledButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            viewModel.email =
                                                emailController.text;
                                            viewModel.onIntent(
                                              ForgotPasswordIntent(),
                                            );
                                          }
                                        },
                                        child: Text(appLocalizations.sendOtp),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              listener: (context, state) {
                                if (state.sendEmailStatus ==
                                    SendEmailStatus.success) {
                                  displaySnackBar(
                                    contentType: ContentType.success,
                                    title: appLocalizations.success,
                                    message: appLocalizations.codeSendTitle,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => ResetCodeScreen(
                                            viewModel: viewModel,
                                          ),
                                    ),
                                  );
                                } else if (state.sendEmailStatus ==
                                    SendEmailStatus.error) {
                                  displaySnackBar(
                                    contentType: ContentType.failure,
                                    title: appLocalizations.error,
                                    message: state.error,
                                  );
                                }
                              },
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
      ),
    );
  }
}
