import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/ui/widgets/profile_item.dart';

import '../../../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../../../core/colors/app_colors.dart';
import '../../../../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../../../../core/widgets/custom_network_cached_image.dart';
import '../../../../../../../shared_layers/localization/enums/languages_enum.dart';
import '../view_model/profile_cubit.dart';

class SuccessState extends StatefulWidget {
  const SuccessState({super.key, required this.state, required this.cubit});

  final ProfileState state;
  final ProfileCubit cubit;

  @override
  State<SuccessState> createState() => _SuccessStateState();
}

class _SuccessStateState extends BaseStatefulWidgetState<SuccessState> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              CustomNetworkCachedImage(
                height: 100,
                width: 100,
                radius: 100,
                fit: BoxFit.cover,
                imageUrl: widget.state.userEntity?.photo ?? '',
              ),
              const SizedBox(height: 4),
              Text(
                widget.state.userEntity?.fullName ?? '',
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
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
                        onTrailingTap: () {},
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
          (context) => AlertDialog(
            title: Text(appLocalizations.logout),
            content: Text(appLocalizations.areYouSureLogout),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(appLocalizations.logoutCancel),
              ),
              TextButton(
                onPressed: () {
                  widget.cubit.doIntent(LogoutIntent());
                  Navigator.pushReplacementNamed(
                    context,
                    DefinedRoutes.loginScreenRoute,
                  );
                },
                child: Text(appLocalizations.confirm),
              ),
            ],
          ),
    );
  }
}
