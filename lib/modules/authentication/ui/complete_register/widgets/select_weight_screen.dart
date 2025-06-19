import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../../core/colors/app_colors.dart';
import '../view_model/complete_register_cubit.dart';

class SelectWeightScreen extends StatefulWidget {
  const SelectWeightScreen({super.key});

  @override
  State<SelectWeightScreen> createState() => _SelectWeightScreenState();
}

class _SelectWeightScreenState
    extends BaseStatefulWidgetState<SelectWeightScreen> {
  int currentValue = 35;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentValue = BlocProvider.of<CompleteRegisterCubit>(context).state.weight;
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
                  text: "What is your weight \n",
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: 'this Helps us create your personalized plan',
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
                  Center(
                    child: Text(
                      'KG',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.mainColorLight,
                      ),
                    ),
                  ),
                  NumberPicker(
                    value: currentValue,
                    minValue: 14,
                    maxValue: 200,
                    itemCount: 5,
                    step: 1,
                    axis: Axis.horizontal,
                    itemHeight: 70,
                    itemWidth: 70,
                    selectedTextStyle: theme.textTheme.titleLarge?.copyWith(
                      color: AppColors.mainColorLight,
                      fontWeight: FontWeight.w800,
                      fontSize: 33,
                    ),
                    textStyle: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                    onChanged: (int value) {
                      setState(() {
                        currentValue = value;
                      });
                    },
                  ),

                  SizedBox(height: screenHeight * 0.01),
                  Icon(
                    Icons.arrow_drop_up,
                    color: AppColors.mainColorLight,
                    size: 35,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  FilledButton(
                    onPressed: () {
                      BlocProvider.of<CompleteRegisterCubit>(
                        context,
                      ).updateStatus(
                        BlocProvider.of<CompleteRegisterCubit>(
                          context,
                        ).state.status,
                        weight: currentValue,
                      );
                    },
                    child: Text('Next'),
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