import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/modules/authentication/ui/register/view_model/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseStatefulWidgetState<RegisterScreen> {
  late ValueNotifier<bool> isObscureNotifier;
  RegisterViewModel registerViewModel = getIt.get<RegisterViewModel>();

  @override
  void initState() {
    super.initState();
    isObscureNotifier = ValueNotifier(true);
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
          title: Image.asset(
            AssetsPaths.fitnessAppIcon,
            width: screenWidth * 0.2,
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                          text: appLocalizations.createAnAccount.toUpperCase(),
                          style: theme.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                    child: Container(
                      width: screenWidth,
                      color: AppColors.black.withAlpha(30),
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16,
                      ),
                      child: Form(
                        key: registerViewModel.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 16,
                          children: [
                            Text(
                              appLocalizations.register,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleLarge!.copyWith(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextFormField(
                              controller: registerViewModel.firstNameController,
                              focusNode: registerViewModel.firstNameNode,
                              validator: (inputText) {
                                return validateFunctions
                                    .validationOfFirstOrLastName(inputText);
                              },
                              onFieldSubmitted: (value) {
                                registerViewModel.lastNameNode.requestFocus();
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: appLocalizations.firstName,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.0,
                                    right: 5,
                                  ),
                                  child: ImageIcon(
                                    AssetImage(AssetsPaths.personIcon),
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: registerViewModel.lastNameController,
                              focusNode: registerViewModel.lastNameNode,
                              validator: (inputText) {
                                return validateFunctions
                                    .validationOfFirstOrLastName(inputText);
                              },
                              onFieldSubmitted: (value) {
                                registerViewModel.emailNode.requestFocus();
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: appLocalizations.lastName,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.0,
                                    right: 5,
                                  ),
                                  child: ImageIcon(
                                    AssetImage(AssetsPaths.personIcon),
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: registerViewModel.emailController,
                              focusNode: registerViewModel.emailNode,
                              validator: (inputText) {
                                return validateFunctions.validationOfEmail(
                                  inputText,
                                );
                              },
                              onFieldSubmitted: (value) {
                                registerViewModel.passwordNode.requestFocus();
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: appLocalizations.email,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.0,
                                    right: 5,
                                  ),
                                  child: ImageIcon(
                                    AssetImage(AssetsPaths.personIcon),
                                  ),
                                ),
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: isObscureNotifier,
                              builder: (context, isObscure, child) {
                                return TextFormField(
                                  controller:
                                      registerViewModel.passwordController,
                                  focusNode: registerViewModel.passwordNode,
                                  validator: (inputText) {
                                    return validateFunctions
                                        .validationOfPassword(inputText);
                                  },
                                  onFieldSubmitted: (value) {
                                    registerViewModel.passwordNode.unfocus();
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: isObscure,
                                  decoration: InputDecoration(
                                    hintText: appLocalizations.password,
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.only(
                                        left: 15.0,
                                        right: 5,
                                      ),
                                      child: ImageIcon(
                                        AssetImage(AssetsPaths.personIcon),
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        isObscureNotifier.value =
                                            !isObscureNotifier.value;
                                      },
                                      icon: Icon(
                                        isObscure
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: AppColors.black[20],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    indent: 30,
                                    endIndent: 20,
                                    color: AppColors.white,
                                    thickness: 2,
                                  ),
                                ),
                                Text(
                                  appLocalizations.or,
                                  style: theme.textTheme.labelMedium,
                                ),
                                Expanded(
                                  child: Divider(
                                    indent: 20,
                                    endIndent: 30,
                                    color: AppColors.white,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    fixedSize: const Size(10, 20),
                                  ),
                                  child: Transform.scale(
                                    scale: 1.3,
                                    child: Image.asset(
                                      AssetsPaths.facebookIcon,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    fixedSize: const Size(10, 20),
                                  ),
                                  child: Transform.scale(
                                    scale: 1.3,
                                    child: Image.asset(AssetsPaths.googleIcon),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    fixedSize: const Size(10, 20),
                                  ),
                                  child: Transform.scale(
                                    scale: 1.3,
                                    child: Image.asset(AssetsPaths.appleIcon),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            FilledButton(
                              onPressed: () {
                                registerViewModel.formKey.currentState!
                                    .validate();
                              },
                              child: Text(appLocalizations.register),
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "${appLocalizations.alreadyHaveAccount} ",
                                    style: theme.textTheme.labelLarge,
                                  ),
                                  WidgetSpan(
                                    baseline: TextBaseline.alphabetic,
                                    alignment: PlaceholderAlignment.baseline,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        appLocalizations.login,
                                        style: theme.textTheme.labelLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.mainColorDark,
                                              decoration:
                                                  TextDecoration.underline,
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
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
