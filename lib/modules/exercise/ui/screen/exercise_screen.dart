import 'dart:ui';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/apis/api_error/api_error_handler.dart';
import '../../../../core/bases/base_stateful_widget_state.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_paths/assets_paths.dart';
import '../../../../core/di/injectable_initializer.dart';
import '../../../../core/widgets/loading_state_widget.dart';
import '../cubit/state.dart';
import '../cubit/view_model.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends BaseStatefulWidgetState<ExerciseScreen> {
  final ExerciseViewModel exerciseViewModel = getIt.get<ExerciseViewModel>();

  @override
  void initState() {
    super.initState();
    exerciseViewModel.doIntent(
      Exercise('67c8499726895f87ce0aa9bc', '67c797e226895f87ce0aa94b'),
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
        child: BlocConsumer<ExerciseViewModel, ExerciseState>(
          listener: (context, state) {
            if (state.status == Status.loading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const LoadingStateWidget(),
              );
            } else if (state.status == Status.error) {
              displaySnackBar(
                contentType: ContentType.failure,
                title: 'Error',
                message: getIt.get<ApiErrorHandler>().handle(state.error!),
                durationInSeconds: 6,
              );
            }
          },
          builder: (context, state) {
            if (state.status == Status.success) {
              return SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 500,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child:
                                    state.selectedThumbnailUrl != null
                                        ? Image.network(
                                          state.selectedThumbnailUrl!,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (_, __, ___) => Image.asset(
                                                AssetsPaths.fitnessAppIcon,
                                                fit: BoxFit.cover,
                                              ),
                                        )
                                        : Image.asset(
                                          AssetsPaths.fitnessAppIcon,
                                          fit: BoxFit.cover,
                                        ),
                              ),
                              Container(color: Colors.black.withOpacity(0.3)),
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
                                      '${state.exercises[1].targetMuscleGroup}',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                  color: AppColors.black.withAlpha(30),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: screenHeight * 0.5,
                                      child: ListView.builder(
                                        itemCount: state.exercises.length,
                                        itemBuilder: (context, index) {
                                          final thumbnail =
                                              state.thumbnailUrl[index];
                                          return ListTile(
                                            onTap: () {
                                              exerciseViewModel.doIntent(
                                                SelectThumbnail(thumbnail),
                                              );
                                            },
                                            contentPadding:
                                                const EdgeInsets.all(5.0),
                                            leading: Image.network(
                                              thumbnail,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (
                                                context,
                                                child,
                                                loadingProgress,
                                              ) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return const CircularProgressIndicator();
                                              },
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return Image.asset(
                                                  AssetsPaths.fitnessAppIcon,
                                                );
                                              },
                                            ),
                                            title: Text(
                                              state
                                                      .exercises[index]
                                                      .targetMuscleGroup ??
                                                  'Exercise',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(fontSize: 18),
                                            ),
                                            subtitle: Text(
                                              '${state.exercises[index].difficultyLevel ?? ""}\n${state.exercises[index].posture ?? ""}',
                                              style: theme.textTheme.labelLarge,
                                            ),
                                            trailing: const Image(
                                              image: AssetImage(
                                                AssetsPaths.playBtn,
                                              ),
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
              );
            }

            return const Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(child: LoadingStateWidget()),
            );
          },
        ),
      ),
    );
  }
}
