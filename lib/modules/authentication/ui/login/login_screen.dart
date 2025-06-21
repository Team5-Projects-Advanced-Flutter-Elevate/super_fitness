import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/authentication/ui/login/state.dart';

import '../../../../core/apis/api_error/api_error_handler.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/di/injectable_initializer.dart';
import 'cubit/login/view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseStatefulWidgetState<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  final email = TextEditingController();
  final password = TextEditingController();
  bool isPasswordObscure = true;
  LoginViewModel loginViewModel = getIt.get<LoginViewModel>();

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
          create: (context) => loginViewModel,
          child: BlocListener<LoginViewModel, LoginState>(
            listener: (context, state) {
              switch (state.loginStatus) {
                case Status.idle:
                  break;
                case Status.loading:
                  const LoadingStateWidget();

                case Status.success:
                  displaySnackBar(
                    contentType: ContentType.success,
                    title: 'Success',
                    message: 'Login Successfully',
                  );
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    DefinedRoutes.homeScreenRoute,
                    (route) => false,
                  );

                case Status.error:
                  displaySnackBar(
                    contentType: ContentType.success,
                    title: 'Error',
                    message: getIt.get<ApiErrorHandler>().handle(state.error!),
                    durationInSeconds: 6,
                  );
              }
            },
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Image.asset(
                    AssetsPaths.fitnessAppIcon,
                    width: screenWidth * 0.2,
                  ),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${appLocalizations.heyThere}\n",
                                  style: theme.textTheme.titleMedium,
                                ),
                                TextSpan(
                                  text:
                                      appLocalizations.welcomeBack
                                          .toUpperCase(),
                                  style: theme.textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppColors.black.withAlpha(
                                    (30).toInt(),
                                  ),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          appLocalizations.login,
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w900,
                                              ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 0.02 * screenHeight),
                                    TextFormField(
                                      controller: email,
                                      validator: (value) {
                                        return validateFunctions
                                            .validationOfEmail(value);
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.only(
                                            left: 15.0,
                                            right: 5,
                                          ),
                                          child: Icon(Icons.mail_outline),
                                        ),
                                        hintText: appLocalizations.email,
                                      ),
                                    ),
                                    SizedBox(height: 0.02 * screenHeight),
                                    TextFormField(
                                      controller: password,
                                      obscuringCharacter: "*",
                                      obscureText: isPasswordObscure,
                                      validator: (value) {
                                        return validateFunctions
                                            .validationOfPassword(value);
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.only(
                                            left: 15.0,
                                            right: 5,
                                          ),
                                          child: Icon(Icons.lock_outlined),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isPasswordObscure =
                                                  !isPasswordObscure;
                                            });
                                          },
                                          icon: Icon(
                                            isPasswordObscure
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                        ),

                                        hintText: appLocalizations.password,
                                      ),
                                    ),

                                    SizedBox(height: 0.02 * screenHeight),

                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        appLocalizations.forgotPassword,
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w900,
                                              color: AppColors.mainColorLight,
                                            ),
                                      ),
                                    ),

                                    SizedBox(height: 0.02 * screenHeight),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 30,
                                        right: 30,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Divider(
                                              color: AppColors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Text(
                                              appLocalizations.or,
                                              style: TextStyle(
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 0.02 * screenHeight),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            backgroundColor: AppColors.black,

                                            fixedSize: const Size(32, 32),
                                          ),
                                          child: Transform.scale(
                                            scale: 1.3,
                                            child: Image.asset(
                                              AssetsPaths.facebookIcon,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            loginViewModel.doIntent(
                                              GoogleLogin(),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.black,

                                            shape: const CircleBorder(),
                                            fixedSize: const Size(32, 32),
                                          ),
                                          child: Transform.scale(
                                            scale: 1.3,
                                            child: Image.asset(
                                              AssetsPaths.googleIcon,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.black,
                                            shape: const CircleBorder(),
                                            fixedSize: const Size(32, 32),
                                          ),
                                          child: Transform.scale(
                                            scale: 1.3,
                                            child: Image.asset(
                                              AssetsPaths.appleIcon,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 0.02 * screenHeight),

                                    FilledButton(
                                      onPressed: () {
                                        loginViewModel.doIntent(
                                          Login(email.text, password.text),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        // backgroundColor: Colors.orange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        appLocalizations.login,
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900,
                                            ),
                                      ),
                                    ),

                                    SizedBox(height: 0.02 * screenWidth),

                                    Text.rich(
                                      textAlign: TextAlign.center,
                                      TextSpan(
                                        text: appLocalizations.noAccount,
                                        style: TextStyle(
                                          color: AppColors.white,
                                        ),
                                        children: [
                                          WidgetSpan(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  DefinedRoutes
                                                      .allRegisterFeature,
                                                );
                                              },
                                              child: Text(
                                                appLocalizations.register,
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color:
                                                      AppColors.mainColorLight,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
