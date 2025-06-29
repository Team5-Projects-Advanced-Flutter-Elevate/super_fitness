import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bases/base_inherited_widget.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/widgets/custom_network_cached_image.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/ui/view_model/profile_cubit.dart';
import '../../../../../../core/colors/app_colors.dart';
import '../../../../../../core/widgets/error_state_widget.dart';
import '../../../../../../shared_layers/localization/enums/languages_enum.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseStatefulWidgetState<ProfilePage> {
  ProfileCubit profileCubit = getIt<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    profileCubit.doIntent(GetProfileDataIntent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: BlocProvider(
          create: (context) => profileCubit,
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              switch (state.status) {
                case ProfileStatus.initial:
                case ProfileStatus.loading:
                  return const LoadingStateWidget();
                case ProfileStatus.success:
                  return SuccessState(state: state);
                case ProfileStatus.error:
                  return ErrorStateWidget(error: state.getProfileError!);
              }
            },
          ),
        ),
      ),
    );
  }
}

class SuccessState extends StatefulWidget {
  const SuccessState({super.key, required this.state});

  final ProfileState state;

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
          flex: 2,
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
        const SizedBox(height: 30),
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
              child: Container(
                width: screenWidth,
                color: AppColors.black.withAlpha(150),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  spacing: 2,
                  children: [
                    ProfileItem(
                      title: 'Edit Profile ',
                      leadingIcon: AssetsPaths.profileIcon,
                      onTrailingTap: () {},
                    ),
                    const Divider(color: Color(0xFF2D2D2D)),
                    ProfileItem(
                      title: 'Change Password ',
                      leadingIcon: AssetsPaths.changePasswordIcon,
                      onTrailingTap: () {},
                    ),
                    const Divider(color: Color(0xFF2D2D2D)),
                    ProfileItem(
                      title: 'Select Language',
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
                      title: 'Security',
                      leadingIcon: AssetsPaths.securityIcon,
                      onTrailingTap: () {},
                    ),
                    const Divider(color: Color(0xFF2D2D2D)),
                    ProfileItem(
                      title: 'Privacy Policy',
                      leadingIcon: AssetsPaths.privacyIcon,
                      onTrailingTap: () {},
                    ),
                    const Divider(color: Color(0xFF2D2D2D)),
                    ProfileItem(
                      title: 'Help',
                      leadingIcon: AssetsPaths.helpIcon,
                      onTrailingTap: () {},
                    ),
                    const Divider(color: Color(0xFF2D2D2D)),
                    ProfileItem(
                      title: 'Logout',
                      leadingIcon: AssetsPaths.logoutIcon,
                      onTrailingTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}

class ProfileItem extends BaseStatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.switchWidget,
    this.isSwitch = false,
    this.onTrailingTap,
  });

  final String leadingIcon;
  final String title;
  final bool isSwitch;
  final Widget? switchWidget;
  final VoidCallback? onTrailingTap;

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return Row(
      children: [
        ImageIcon(AssetImage(leadingIcon), color: AppColors.mainColorLight),
        const SizedBox(width: 16),
        isSwitch
            ? RichText(
              text: TextSpan(
                text: title,
                style: inherit.theme.textTheme.titleLarge?.copyWith(
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: ' ( ',
                    style: inherit.theme.textTheme.titleLarge?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text:
                        inherit.localizationManager.currentLocale ==
                                LanguagesEnum.en.getLanguageCode()
                            ? 'English'
                            : 'العربية',
                    style: inherit.theme.textTheme.titleLarge?.copyWith(
                      fontSize: 14,
                      color: AppColors.mainColorLight,
                    ),
                  ),
                  TextSpan(
                    text: ' )',
                    style: inherit.theme.textTheme.titleLarge?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
            : Text(
              title,
              style: inherit.theme.textTheme.titleLarge?.copyWith(fontSize: 14),
            ),
        const Spacer(),
        isSwitch
            ? switchWidget!
            : GestureDetector(
              onTap: onTrailingTap,
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.mainColorLight,
              ),
            ),
      ],
    );
  }
}
