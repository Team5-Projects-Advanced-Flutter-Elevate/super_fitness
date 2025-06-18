import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/constants/assets_paths/assets_paths.dart';
import '../view_model/complete_register_cubit.dart';

class SelectGenderScreen extends StatefulWidget {
  const SelectGenderScreen({super.key});

  @override
  State<SelectGenderScreen> createState() => _SelectGenderScreenState();
}

class _SelectGenderScreenState
    extends BaseStatefulWidgetState<SelectGenderScreen> {
  bool? isMale;

  @override
  void initState() {
    super.initState();
    isMale = BlocProvider.of<CompleteRegisterCubit>(context).state.isMale;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Tell us about your self ! \n",
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: 'We need to know your gender',
                  style: theme.textTheme.titleMedium,
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
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = true;
                      });
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isMale != null
                                ? isMale!
                                    ? AppColors.mainColorLight
                                    : Colors.transparent
                                : Colors.transparent,
                        border: Border.all(
                          color:
                              isMale != null
                                  ? isMale!
                                      ? Colors.transparent
                                      : AppColors.white
                                  : AppColors.white,
                        ),
                      ),
                      child: Column(
                        children: [
                          const ImageIcon(
                            AssetImage(AssetsPaths.maleIcon),
                            size: 40,
                          ),

                          const SizedBox(height: 6),
                          Text(
                            'Male',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(fontSize: 9 * (screenWidth / 375)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = false;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          padding: const EdgeInsets.all(6),

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                isMale != null
                                    ? !isMale!
                                        ? AppColors.mainColorLight
                                        : Colors.transparent
                                    : Colors.transparent,
                            border: Border.all(
                              color:
                                  isMale != null
                                      ? !isMale!
                                          ? Colors.transparent
                                          : AppColors.white
                                      : AppColors.white,
                            ),
                          ),
                          child: Column(
                            children: [
                              const ImageIcon(
                                AssetImage(AssetsPaths.femaleIcon),
                                size: 40,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Female',
                                style: Theme.of(
                                  context,
                                ).textTheme.labelSmall?.copyWith(
                                  fontSize: 9 * (screenWidth / 375),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  FilledButton(
                    onPressed:
                        isMale == null
                            ? null
                            : () {
                              BlocProvider.of<CompleteRegisterCubit>(
                                context,
                              ).updateStatus(
                                BlocProvider.of<CompleteRegisterCubit>(
                                  context,
                                ).state.status,
                                isMale: isMale,
                              );
                            },
                    child: Text("Next"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
