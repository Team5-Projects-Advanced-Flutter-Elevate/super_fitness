import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/modules/edit_profile/ui/screens/goal_screen.dart';
import 'package:super_fitness/modules/edit_profile/ui/screens/weight_screen.dart';

import '../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../core/di/injectable_initializer.dart';
import '../../../../core/utilities/image_picker.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_state_widget.dart';
import '../cubit/states.dart';
import '../cubit/view_model.dart';
import 'activity_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState
    extends BaseStatefulWidgetState<EditProfileScreen> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final goal = TextEditingController();
  final weight = TextEditingController();
  final level = TextEditingController();

  bool isDirty = false;
  bool _initialized = false; // ✅ hydration flag

  late EditProfileViewModel editProfileViewModel;

  @override
  void initState() {
    super.initState();
    editProfileViewModel = getIt.get<EditProfileViewModel>();
    editProfileViewModel.onIntent(EditProfileIntent());

    firstName.addListener(_checkDirty);
    lastName.addListener(_checkDirty);
    email.addListener(_checkDirty);
    password.addListener(_checkDirty);
    goal.addListener(_checkDirty);
    weight.addListener(_checkDirty);
    level.addListener(_checkDirty);
  }

  void _checkDirty() {
    final state = editProfileViewModel.state;
    final changed =
        firstName.text != state.initialData?.firstName ||
        lastName.text != state.initialData?.lastName ||
        email.text != state.initialData?.email ||
        goal.text != state.initialData?.goal ||
        weight.text != state.initialData?.weight ||
        level.text != state.initialData?.level;

    if (changed != isDirty) {
      setState(() {
        isDirty = changed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPaths.homeBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.mainColorLight,
                child: const ImageIcon(
                  AssetImage(AssetsPaths.backIcon),
                  size: 12,
                ),
              ),
            ),
          ),
          title: Text(appLocalizations.editProfile),
        ),
        body: BlocProvider(
          create: (_) => editProfileViewModel,
          child: BlocConsumer<EditProfileViewModel, ProfileState>(
            listener: (context, state) {
              if (state.updateProfileStatus == EditProfileStatus.success) {
                displaySnackBar(
                  contentType: ContentType.success,
                  title: appLocalizations.success,
                  message: appLocalizations.updatedSuccessfully,
                );
                _initialized = false;
              }

              if (state.uploadImageStatus == EditProfileStatus.success) {
                displaySnackBar(
                  contentType: ContentType.success,
                  title: appLocalizations.success,
                  message: appLocalizations.updatedSuccessfully,
                );
              } else if (state.uploadImageStatus == EditProfileStatus.error) {
                ErrorStateWidget(error: state.error.toString());
              }
            },
            builder: (context, state) {
              if (!_initialized &&
                  state.getProfileDataStatus == EditProfileStatus.success) {
                firstName.text = state.firstName;
                lastName.text = state.lastName;
                email.text = state.email;
                goal.text = state.goal;
                weight.text = state.weight;
                level.text = state.level;
                _initialized = true;
              }
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),

                  child:
                      state.getProfileDataStatus == EditProfileStatus.loading
                          ? SizedBox(
                            height: screenHeight * 0.7,
                            child: const Center(child: LoadingStateWidget()),
                          )
                          : Column(
                            spacing: 15,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      InkWell(
                                        onTap:
                                            () => ImagePickerService()
                                                .showImageSourceDialog(
                                                  context,
                                                  onImageSelected: (image) {
                                                    editProfileViewModel
                                                        .onIntent(
                                                          LoadProfileImageIntent(
                                                            image,
                                                          ),
                                                        );
                                                  },
                                                ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.mainColorDark
                                                    .withAlpha(80),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: CircleAvatar(
                                            radius: 50,
                                            backgroundColor: AppColors.black,
                                            child:
                                                state.profilePhotoLink == null
                                                    ? const Icon(Icons.person)
                                                    : (state.profilePhotoLink!
                                                            .startsWith('http')
                                                        ? CircleAvatar(
                                                          backgroundColor:
                                                              AppColors.black,
                                                          radius: 40,
                                                          backgroundImage:
                                                              CachedNetworkImageProvider(
                                                                state
                                                                    .profilePhotoLink!,
                                                              ),
                                                        )
                                                        : CircleAvatar(
                                                          backgroundColor:
                                                              AppColors.black,
                                                          radius: 40,
                                                          backgroundImage:
                                                              FileImage(
                                                                File(
                                                                  state
                                                                      .profilePhotoLink!,
                                                                ),
                                                              ),
                                                        )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${state.firstName} ${state.lastName}',
                                    style: theme.textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: firstName,
                                decoration: const InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                      left: 15.0,
                                      right: 5,
                                    ),
                                    child: Icon(Icons.person),
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: lastName,
                                decoration: const InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                      left: 15.0,
                                      right: 5,
                                    ),
                                    child: Icon(Icons.person),
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: email,
                                decoration: const InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                      left: 15.0,
                                      right: 5,
                                    ),
                                    child: Icon(Icons.email),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text.rich(
                                textAlign: TextAlign.start,
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Text(
                                        appLocalizations.yourWeight,
                                        style: theme.textTheme.titleLarge,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: screenWidth * 0.02,
                                      ),
                                    ),

                                    WidgetSpan(
                                      child: Text(
                                        appLocalizations.tapToEdit,
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                              color: AppColors.mainColorDark,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              StatefulBuilder(
                                builder: (context, localSetState) {
                                  return TextFormField(
                                    controller: weight,
                                    readOnly: true,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => WeightScreen(
                                                onSelected: (selectedWeight) {
                                                  localSetState(() {
                                                    weight.text =
                                                        selectedWeight
                                                            .toString();
                                                  });
                                                },
                                              ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              Text.rich(
                                textAlign: TextAlign.start,
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Text(
                                        appLocalizations.yourGoal,
                                        style: theme.textTheme.titleLarge,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: screenWidth * 0.02,
                                      ),
                                    ),

                                    WidgetSpan(
                                      child: Text(
                                        appLocalizations.tapToEdit,
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                              color: AppColors.mainColorDark,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              StatefulBuilder(
                                builder: (context, localSetState) {
                                  return TextFormField(
                                    controller: goal,
                                    readOnly: true,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => GoalScreen(
                                                onSelected: (selectedGoal) {
                                                  localSetState(() {
                                                    goal.text = selectedGoal;
                                                  });
                                                },
                                              ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              Text.rich(
                                textAlign: TextAlign.start,
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Text(
                                        appLocalizations.yourActivityLevel,
                                        style: theme.textTheme.titleLarge,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: screenWidth * 0.02,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Text(
                                        appLocalizations.tapToEdit,
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                              color: AppColors.mainColorDark,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              StatefulBuilder(
                                builder: (context, localSetState) {
                                  return TextFormField(
                                    controller: level,
                                    readOnly: true,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => ActivityScreen(
                                                onSelected: (selectedActivity) {
                                                  localSetState(() {
                                                    level.text =
                                                        selectedActivity;
                                                    _checkDirty();
                                                  });
                                                },
                                              ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              state.updateProfileStatus ==
                                      EditProfileStatus.loading
                                  ? const Center(child: LoadingStateWidget())
                                  : FilledButton(
                                    onPressed:
                                        isDirty
                                            ? () {
                                              editProfileViewModel.onIntent(
                                                EditInfo(
                                                  firstName.text,
                                                  lastName.text,
                                                  email.text,
                                                  goal.text,
                                                  weight.text,
                                                  level.text,
                                                ),
                                              );
                                            }
                                            : null,
                                    child: Text(appLocalizations.update),
                                  ),
                            ],
                          ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
