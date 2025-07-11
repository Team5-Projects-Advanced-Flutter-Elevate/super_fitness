import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_inherited_widget.dart';
import 'package:super_fitness/modules/exercise/ui/screen/video_player.dart';

import '../../../../core/bases/base_statless_widget.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';
import '../../domain/entity/get_exercise.dart';

class ExerciseListWidget extends BaseStatelessWidget {
  final List<ExerciseEntity> exercises;
  final List<String> thumbnails;
  final String? selectedThumbnailUrl;
  final String? selectedShortVideoUrl;

  final void Function(String thumbnail, String shortLink) onThumbnailTap;

  const ExerciseListWidget({
    super.key,
    required this.exercises,
    required this.thumbnails,
    required this.selectedThumbnailUrl,
    this.selectedShortVideoUrl,
    required this.onThumbnailTap,
  });

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return exercises.isEmpty
        ? Center(
          child: Text(
            inherit.appLocalizations.noVideoProvided,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
        : ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            final thumbnail = thumbnails[index];
            final shortLink = exercise.shortYoutubeDemonstrationLink;
            return ListTile(
              onTap: () {
                if (shortLink != null) {
                  onThumbnailTap(thumbnail, shortLink);
                }
              },
              contentPadding: const EdgeInsets.all(5.0),
              leading: Image.network(
                thumbnail,
                fit: BoxFit.cover,
                loadingBuilder:
                    (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : const CircularProgressIndicator(),
                errorBuilder:
                    (context, error, stackTrace) =>
                        Image.asset(AssetsPaths.fitnessAppIcon),
              ),
              title: Text(
                exercise.targetMuscleGroup ?? '',
                style: inherit.theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                '${exercise.difficultyLevel ?? ""}\n${exercise.posture ?? ""}',
                style: inherit.theme.textTheme.labelLarge,
              ),
              trailing: GestureDetector(
                onTap: () {
                  if (exercise.shortYoutubeDemonstrationLink == null) {
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PlayerScreen(
                            url: '${exercise.shortYoutubeDemonstrationLink}',
                          ),
                    ),
                  );
                },

                child: const Image(image: AssetImage(AssetsPaths.playBtn)),
              ),
            );
          },
        );
  }
}
