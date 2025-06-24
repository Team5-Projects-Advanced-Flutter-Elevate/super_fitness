import 'dart:ui';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/modules/exercise/ui/screen/exercise_header.dart';
import 'package:super_fitness/modules/exercise/ui/screen/exersice_list.dart';
import '../../../../core/apis/api_error/api_error_handler.dart';
import '../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../core/di/injectable_initializer.dart';
import '../../../../core/widgets/loading_state_widget.dart';
import '../cubit/state.dart';
import '../cubit/view_model.dart';

class ExerciseScreen extends StatefulWidget {
  final String muscleId;
  const ExerciseScreen({super.key, required this.muscleId});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends BaseStatefulWidgetState<ExerciseScreen> {
  final ExerciseViewModel exerciseViewModel = getIt.get<ExerciseViewModel>();
  late num selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    exerciseViewModel.doIntent(
      Exercise(widget.muscleId, '67c797e226895f87ce0aa94b'),
    );
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
      child: BlocProvider(
        create: (context) => exerciseViewModel,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BlocBuilder<ExerciseViewModel, ExerciseState>(
                    builder: (context, state) {
                      return SizedBox(
                        height: 500,
                        child:
                            state.status == Status.loading
                                ? const LoadingStateWidget()
                                : ExerciseHeaderSection(state: '${state.selectedShortLink}',targetMuscleGroup: '${state.exercises[0].targetMuscleGroup}',),
                      );
                    },
                  ),
                  SizedBox(height: 0.01 * screenHeight),
                  Container(
                    padding: const EdgeInsets.all(9.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: AppColors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _buildTab(
                          context,
                          '67c797e226895f87ce0aa94b',
                          0,
                          appLocalizations.beginner,
                        ),
                        _buildTab(
                          context,
                          '67c797e226895f87ce0aa94c',
                          1,
                          appLocalizations.intermediate,
                        ),
                        _buildTab(
                          context,
                          '67c797e226895f87ce0aa94e',
                          2,
                          appLocalizations.advanced,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.01 * screenHeight),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.black.withAlpha(30),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: screenHeight * 0.5,
                                child: BlocBuilder<
                                  ExerciseViewModel,
                                  ExerciseState
                                >(
                                  builder: (context, state) {
                                    if (state.status == Status.success) {
                                      return ExerciseListWidget(
                                        exercises: state.exercises,
                                        thumbnails: state.thumbnailUrl,
                                        selectedThumbnailUrl:
                                            state.selectedThumbnailUrl,
                                        onThumbnailTap: (thumbnail,shortVideoUrl) {
                                          exerciseViewModel.doIntent(
                                            SelectThumbnail(thumbnail),
                                          );
                                          exerciseViewModel.doIntent(
                                            SelectShortVideo(shortVideoUrl),
                                          );

                                        },
                                      );
                                    } else if (state.status == Status.loading) {
                                      return const LoadingStateWidget();
                                    } else if (state.status == Status.error) {
                                      displaySnackBar(
                                        contentType: ContentType.failure,
                                        title: appLocalizations.error,
                                        message: getIt
                                            .get<ApiErrorHandler>()
                                            .handle(state.error!),
                                        durationInSeconds: 6,
                                      );
                                      return const SizedBox(); // or show a retry button
                                    } else {
                                      return const SizedBox();
                                    }
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
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    String levelId,
    int index,
    String label,
  ) {
    final bool isSelected = index == selectedTabIndex;

    return GestureDetector(
      onTap: () {
        if (isSelected) return;
        setState(() {
          selectedTabIndex = index;
        });
        exerciseViewModel.doIntent(Exercise(widget.muscleId, levelId));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColorLight : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
