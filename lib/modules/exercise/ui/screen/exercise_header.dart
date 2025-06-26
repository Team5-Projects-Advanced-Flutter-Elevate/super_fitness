import 'package:flutter/material.dart';
import 'package:super_fitness/modules/exercise/ui/screen/video_player.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';

class ExerciseHeaderSection extends StatelessWidget {
  final String state;
  final String targetMuscleGroup;
  final String selectedThumbnail;

  const ExerciseHeaderSection({
    super.key,
    required this.state,
    required this.targetMuscleGroup,
    required this.selectedThumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child:
                state.isNotEmpty
                    ? PlayerScreen(url: state)
                    : Image.network(
                      selectedThumbnail,
                      fit: BoxFit.cover,
                      loadingBuilder:
                          (context, child, loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                      errorBuilder:
                          (context, error, stackTrace) =>
                              Image.asset(AssetsPaths.fitnessAppIcon),
                    ),
          ),

          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: AppColors.mainColorLight,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const ImageIcon(
                  AssetImage(AssetsPaths.backIcon),
                  size: 15,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  targetMuscleGroup.isNotEmpty ? targetMuscleGroup : '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IgnorePointer(
            ignoring: true,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: 0.3),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
              ),
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
