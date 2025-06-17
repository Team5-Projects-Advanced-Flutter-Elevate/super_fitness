import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseStatefulWidgetState<RegisterScreen> {
  late ValueNotifier<bool> isObscureNotifier;

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
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Hey There\n",
                          style: theme.textTheme.titleMedium,
                        ),
                        TextSpan(
                          text: "create an account".toUpperCase(),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 16,
                        children: [
                          Text(
                            "Register",
                            style: theme.textTheme.titleLarge!.copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextFormField(
                            validator: (inputText) {
                              return validateFunctions
                                  .validationOfFirstOrLastName(inputText);
                            },
                            decoration: const InputDecoration(
                              hintText: "First Name",
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 15.0, right: 5),
                                child: ImageIcon(
                                  AssetImage(AssetsPaths.personIcon),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (inputText) {
                              return validateFunctions
                                  .validationOfFirstOrLastName(inputText);
                            },
                            decoration: const InputDecoration(
                              hintText: "Last Name",
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 15.0, right: 5),
                                child: ImageIcon(
                                  AssetImage(AssetsPaths.personIcon),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (inputText) {
                              return validateFunctions.validationOfEmail(
                                inputText,
                              );
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: "Email",
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 15.0, right: 5),
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
                                validator: (inputText) {
                                  return validateFunctions.validationOfPassword(
                                    inputText,
                                  );
                                },
                                obscureText: isObscure,
                                decoration: InputDecoration(
                                  hintText: "Password",
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
                              Text("Or", style: theme.textTheme.labelMedium),
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
    );
  }
}
