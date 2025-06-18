import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/shared_layers/localization/enums/languages_enum.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseStatefulWidgetState<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController textEditingController = TextEditingController();

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
        child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: const Text("Hello"),
            centerTitle: true,
          ),
          bottomNavigationBar: NavigationBar(
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              const NavigationDestination(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 34.0, sigmaY: 34.0),
                          child: Container(
                            width: double.infinity,
                            height: 200.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2424241A).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'Frosted',
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(color: Colors.white, thickness: 1.5),
                    SizedBox(height: screenHeight * 0.03),
                    SizedBox(height: screenHeight * 0.03),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        controller: textEditingController,
                        validator: (value) {
                          return validateFunctions.validationOfEmail(value);
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 5),
                            child: Icon(Icons.mail_outline),
                          ),
                          hintText: "Email",
                        ),
                      ),
                    ),
                    Text(
                      validateFunctions.validationOfEmail("ljklsdkfjldskfj")!,
                      style: theme.textTheme.bodyLarge,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        localizationManager.isEnglish
                            ? await localizationManager.changeLocal(
                              LanguagesEnum.ar.getLanguageCode(),
                            )
                            : await localizationManager.changeLocal(
                              LanguagesEnum.en.getLanguageCode(),
                            );
                        formKey.currentState!.validate();
                      },
                      child: Text(appLocalizations.login),
                    ),
                    FilledButton(onPressed: () {}, child: const Text("Test")),
                    OutlinedButton(
                      onPressed: () {
                        displaySnackBar(
                          contentType: ContentType.success,
                          title: "Displayed Successfully",
                          message: "SnackBar Displayed Successfully",
                        );
                      },
                      child: const Text("Display Snack Bar"),
                    ),
                    const LoadingStateWidget(),
                    Radio<String>(
                      value: "value1",
                      groupValue: "value1",

                      onChanged: (value) {},
                    ),
                    Radio<String>(
                      value: "value1",
                      groupValue: "value2",
                      onChanged: (value) {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            fixedSize: const Size(32, 32),
                          ),
                          child: Transform.scale(
                            scale: 1.3,
                            child: Image.asset(AssetsPaths.facebookIcon),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            fixedSize: const Size(32, 32),
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
                            fixedSize: const Size(32, 32),
                          ),
                          child: Transform.scale(
                            scale: 1.3,
                            child: Image.asset(AssetsPaths.appleIcon),
                          ),
                        ),
                      ],
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
}
