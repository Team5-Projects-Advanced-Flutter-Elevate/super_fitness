import 'package:flutter/material.dart';
import 'package:super_fitness/modules/exercise/ui/screen/video_player.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';

class ExerciseHeaderSection extends StatelessWidget {
  final String state;
  final String targetMuscleGroup;

  const ExerciseHeaderSection({super.key, required this.state,required this.targetMuscleGroup});

  @override
  Widget build(BuildContext context) {
    print('aaaa${state}');
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child:
                state.isNotEmpty
                    ? PlayerScreen(url: state)
                    : Image.asset(
                      AssetsPaths.fitnessAppIcon,
                      fit: BoxFit.cover,
                    ),
          ),
          IgnorePointer(
              ignoring: true,
              child: Container(color: Colors.black.withOpacity(0.3))),
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
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  targetMuscleGroup.isNotEmpty?targetMuscleGroup : '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// Image.network(
// state.selectedThumbnailUrl!,
// fit: BoxFit.cover,
// errorBuilder:
// (_, __, ___) => Image.asset(
// AssetsPaths.fitnessAppIcon,
// fit: BoxFit.cover,
// ),
// )
//     : Image.asset(
// AssetsPaths.fitnessAppIcon,
// fit: BoxFit.cover,
// ),