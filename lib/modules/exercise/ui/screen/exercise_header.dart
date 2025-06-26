import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/exercise/ui/cubit/state.dart';
import 'package:super_fitness/modules/exercise/ui/screen/video_player.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';
import '../cubit/view_model.dart';

class ExerciseHeaderSection extends StatelessWidget {
  final ExerciseViewModel viewModel;

  const ExerciseHeaderSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseViewModel, ExerciseState>(
      builder: (context, state) {
        return SizedBox(
          height: 500,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Builder(
                  builder: (context) {
                    if (state.status == Status.loading) {
                      return const LoadingStateWidget();
                    } else if (state.status == Status.success) {
                      if (state.selectedShortLink!.isNotEmpty) {
                        return PlayerScreen(url: '${state.selectedShortLink}');
                      } else {
                        return PlayerScreen(
                          url:
                              '${state.exercises[0].shortYoutubeDemonstrationLink}',
                        );
                      }
                    } else if (state.status == Status.error) {
                      return Image.network(
                        state.thumbnailUrl[1],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(AssetsPaths.fitnessAppIcon);
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
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
                bottom: 80,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Builder(
                      builder: (BuildContext context) {
                        if (state.status == Status.success) {
                          return Text(
                            state.exercises[0].targetMuscleGroup != null
                                ? '${state.exercises[0].targetMuscleGroup}'
                                : '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (state.status == Status.error) {
                          return const Text(
                            'No video Provided',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
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
      },
    );
  }
}
