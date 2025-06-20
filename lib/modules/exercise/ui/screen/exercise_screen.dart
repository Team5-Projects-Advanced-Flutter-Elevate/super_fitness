import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends BaseStatefulWidgetState<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPaths.homeBg),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 500,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.asset(
                          AssetsPaths
                              .fitnessAppIcon, // your local asset or use Image.network
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Dark overlay
                      Container(color: Colors.black.withOpacity(0.3)),

                      // Back button
                      Positioned(
                        top: 40,
                        left: 16,
                        child: CircleAvatar(
                          backgroundColor: AppColors.mainColorLight,
                          child: const ImageIcon(
                            AssetImage(AssetsPaths.backIcon),
                            size: 15,
                          ),
                        ),
                      ),

                      // Text content
                      Positioned(
                        bottom: 40,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Chest Exercise',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Lorem Ipsum Dolor Sit Amet Consectetur. Tempus Volutpat Ut Nisi Morbi.',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _infoChip('30 MIN'),
                                _infoChip(
                                  '130 Cal',
                                  bgColor: AppColors.mainColorLight,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),


                    ],
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
                          color: AppColors.black.withAlpha((30).toInt()),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: screenHeight*0.5,
                              child: ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    contentPadding: const EdgeInsets.all(8.0),
                                    leading: const Image(
                                      image: AssetImage(
                                        AssetsPaths.fitnessAppIcon,
                                      ),
                                    ),
                                    title: Text(
                                      'Bensh Press',
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      '3 groups * 15 times Lorem ipsum dolor sit  amet consectetur. Tempus ',
                                      style: theme.textTheme.labelLarge,
                                    ),
                                    trailing: const Image(
                                      image: AssetImage(AssetsPaths.playBtn),
                                    ),
                                  );
                                },
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
    );
  }
}

Widget _infoChip(String label, {Color bgColor = Colors.transparent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: bgColor,
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
