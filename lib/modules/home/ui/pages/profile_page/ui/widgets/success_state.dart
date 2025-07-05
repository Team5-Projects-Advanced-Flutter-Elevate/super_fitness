import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/core/utilities/user_provider/user_provider.dart';
import 'package:super_fitness/core/widgets/custom_network_cached_image.dart';
import 'package:super_fitness/modules/edit_profile/ui/screens/edit_profile_screen.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/ui/widgets/profile_item.dart';
import '../../../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../../../core/colors/app_colors.dart';
import '../../../../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../../../../core/di/injectable_initializer.dart';
import '../../../../../../../shared_layers/localization/enums/languages_enum.dart';
import '../../../../../../../shared_layers/localization/l10n_manager/localization_manager.dart';
import '../../../../../../authentication/domain/usecase/login/login_local.dart';

class SuccessState extends StatefulWidget {
  const SuccessState({super.key});

  @override
  State<SuccessState> createState() => _SuccessStateState();
}

class _SuccessStateState extends BaseStatefulWidgetState<SuccessState> {
  late bool isEnglish;
  UserProvider userProvider = getIt<UserProvider>();

  @override
  void initState() {
    super.initState();
    isEnglish =
        getIt<LocalizationManager>().currentLocale ==
        LanguagesEnum.en.getLanguageCode();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<UserProvider>(
          builder: (context, value, child) {
            return Expanded(
              flex: 4,
              child: Column(
                children: [
                  userProvider.userLoginInfo!.user!.hasNetworkImage
                      ? CustomNetworkCachedImage(
                        height: 100,
                        width: 100,
                        radius: 100,
                        fit: BoxFit.cover,
                        imageUrl: userProvider.userLoginInfo?.user?.photo ?? '',
                      )
                      : CircleAvatar(
                        backgroundColor: AppColors.black,
                        radius: 60,
                        backgroundImage: FileImage(
                          File(userProvider.userLoginInfo?.user?.photo ?? ''),
                        ),
                      ),
                  const SizedBox(height: 4),
                  Text(
                    userProvider.userLoginInfo?.user?.fullName ?? '',
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
        Expanded(
          flex: 7,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
              child: Container(
                width: screenWidth,
                color: AppColors.black.withAlpha(150),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    spacing: 2,
                    children: [
                      ProfileItem(
                        title: appLocalizations.editProfile,
                        leadingIcon: AssetsPaths.profileIcon,
                        onTrailingTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(color: Color(0xFF2D2D2D)),
                      ProfileItem(
                        title: appLocalizations.changePassword,
                        leadingIcon: AssetsPaths.changePasswordIcon,
                        onTrailingTap: () {
                          Navigator.pushNamed(
                            context,
                            DefinedRoutes.changePasswordRoute,
                          );
                        },
                      ),
                      const Divider(color: Color(0xFF2D2D2D)),
                      ProfileItem(
                        title: appLocalizations.selectLanguage,
                        isSwitch: true,
                        switchWidget: Switch(
                          value: isEnglish,
                          onChanged: (val) {
                            final newLocale =
                                localizationManager.currentLocale ==
                                        LanguagesEnum.en.getLanguageCode()
                                    ? LanguagesEnum.ar.getLanguageCode()
                                    : LanguagesEnum.en.getLanguageCode();

                            localizationManager.changeLocal(newLocale);
                            setState(() {
                              isEnglish = val;
                            });
                          },
                        ),
                        leadingIcon: AssetsPaths.languageIcon,
                      ),
                      const Divider(color: Color(0xFF2D2D2D)),
                      ProfileItem(
                        title: appLocalizations.security,
                        leadingIcon: AssetsPaths.securityIcon,
                        onTrailingTap: () {},
                      ),
                      const Divider(color: Color(0xFF2D2D2D)),
                      ProfileItem(
                        title: appLocalizations.privacyPolicy,
                        leadingIcon: AssetsPaths.privacyIcon,
                        onTrailingTap: () {},
                      ),
                      const Divider(color: Color(0xFF2D2D2D)),
                      ProfileItem(
                        title: appLocalizations.help,
                        leadingIcon: AssetsPaths.helpIcon,
                        onTrailingTap: () {},
                      ),
                      const Divider(color: Color(0xFF2D2D2D)),
                      ProfileItem(
                        title: appLocalizations.logout,
                        leadingIcon: AssetsPaths.logoutIcon,
                        onTrailingTap: () {
                          showLogoutDialog();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder:
          (context) => Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.2,
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.black.withAlpha(150),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    Text(
                      appLocalizations.areYouSureLogout,
                      style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    Row(
                      spacing: 30,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(appLocalizations.logoutCancel),
                          ),
                        ),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              getIt<StoreLoginLocalUseCase>().clear();
                              Navigator.pushReplacementNamed(
                                context,
                                DefinedRoutes.loginScreenRoute,
                              );
                            },
                            child: Text(appLocalizations.confirm),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
