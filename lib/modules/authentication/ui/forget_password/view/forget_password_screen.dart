import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/modules/authentication/ui/forget_password/view/reset_code_screen.dart';

import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../core/validation/validation_functions.dart';
import '../../../../../core/widgets/loading_state_widget.dart';
import '../view_model/email_view_model.dart';
import '../view_model/forget_password_state.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

late TextEditingController emailController;

class _ForgetPasswordScreenState
    extends BaseStatefulWidgetState<ForgetPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EmailViewModel emailViewModel = getIt.get<EmailViewModel>();

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
      create: (context) => emailViewModel,
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
              title: Text(
                appLocalizations.password,
                style: theme.textTheme.headlineMedium,
              ),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    Text(
                      appLocalizations.forgetPassword,
                      style: theme.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      appLocalizations.pleaseEnterEmail,
                      style: theme.textTheme.bodyLarge,
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator:
                          (value) => getIt<ValidateFunctions>()
                              .validationOfEmail(value),

                      controller: emailController,
                      decoration: InputDecoration(
                        enabled: true,
                        hintText: appLocalizations.email,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 5),
                          child: Icon(Icons.mail_outline),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.06),
                    BlocConsumer<EmailViewModel, EmailState>(
                      builder: (context, state) {
                        if (state is EmailLoadingState) {
                          return loadingAlert();
                        }
                        return FilledButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              emailViewModel.onIntent(
                                ForgotPasswordIntent(
                                  emailController.text.trim(),
                                ),
                              );
                            }
                          },
                          child: Text(appLocalizations.confirm),
                        );
                      },
                      listener: (context, state) {
                        if (state is EmailSuccessState) {
                          alert('success', '');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ResetCodeScreen(
                                    email: emailController.text.trim(),
                                  ),
                            ),
                          );
                        } else if (state is EmailErrorState) {
                          alert('failed', state.toString());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
    } else {
      return displaySnackBar(
        contentType: ContentType.failure,
        title: appLocalizations.error,
        message: msg,
      );
    }
  }
}

Widget loadingAlert() {
  return const LoadingStateWidget();
}
