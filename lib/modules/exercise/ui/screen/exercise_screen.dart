// import 'dart:ui';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:super_fitness/modules/exercise/domain/entity/get_exercise.dart';
// import '../../../../core/apis/api_error/api_error_handler.dart';
// import '../../../../core/bases/base_stateful_widget_state.dart';
// import '../../../../core/colors/app_colors.dart';
// import '../../../../core/constants/assets_paths/assets_paths.dart';
// import '../../../../core/di/injectable_initializer.dart';
// import '../../../../core/widgets/loading_state_widget.dart';
// import '../cubit/state.dart';
// import '../cubit/view_model.dart';
//
// class ExerciseScreen extends StatefulWidget {
//   const ExerciseScreen({super.key});
//
//   @override
//   State<ExerciseScreen> createState() => _ExerciseScreenState();
// }
//
// class _ExerciseScreenState extends BaseStatefulWidgetState<ExerciseScreen> {
//   ExerciseViewModel exerciseViewModel = getIt.get<ExerciseViewModel>();
//   late final List<dynamic> list;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     exerciseViewModel.doIntent(
//       Exercise('67c8499726895f87ce0aa9bc', '67c797e226895f87ce0aa94b'),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(AssetsPaths.homeBg),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: BlocProvider(
//         create: (context) => exerciseViewModel,
//
//         // listener: (context, state) {
//         //   switch (state.status) {
//         //     case Status.idle:
//         //       break;
//         //     case Status.loading:
//         //       const LoadingStateWidget();
//         //
//         //     case Status.success:
//         //       displaySnackBar(
//         //         contentType: ContentType.success,
//         //         title: 'Success',
//         //         message: 'Login Successfully',
//         //       );
//         //       list = state.exercises;
//         //     case Status.error:
//         //       displaySnackBar(
//         //         contentType: ContentType.success,
//         //         title: 'Error',
//         //         message: getIt.get<ApiErrorHandler>().handle(state.error!),
//         //         durationInSeconds: 6,
//         //       );
//         //   }
//         // },
//         child: BlocConsumer<ExerciseViewModel, ExerciseState>(
//           builder: (context, state) {
//             if (state.status == Status.success) {
//               return SafeArea(
//                 child: Scaffold(
//                   body: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         SizedBox(
//                           height: 500,
//                           child: Stack(
//                             children: [
//                               SizedBox(
//                                 width: double.infinity,
//                                 height: double.infinity,
//                                 child: Image.asset(
//                                   AssetsPaths
//                                       .fitnessAppIcon, // your local asset or use Image.network
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//
//                               // Dark overlay
//                               Container(color: Colors.black.withOpacity(0.3)),
//
//                               // Back button
//                               Positioned(
//                                 top: 40,
//                                 left: 16,
//                                 child: CircleAvatar(
//                                   backgroundColor: AppColors.mainColorLight,
//                                   child: const ImageIcon(
//                                     AssetImage(AssetsPaths.backIcon),
//                                     size: 15,
//                                   ),
//                                 ),
//                               ),
//
//                               // Text content
//                               Positioned(
//                                 bottom: 40,
//                                 left: 20,
//                                 right: 20,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Chest Exercise',
//                                       style: TextStyle(
//                                         color: AppColors.white,
//                                         fontSize: 26,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Text(
//                                       'Lorem Ipsum Dolor Sit Amet Consectetur. Tempus Volutpat Ut Nisi Morbi.',
//                                       style: TextStyle(
//                                         color: AppColors.white,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 20),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         _infoChip('30 MIN'),
//                                         _infoChip(
//                                           '130 Cal',
//                                           bgColor: AppColors.mainColorLight,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Center(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(50.0),
//                             child: BackdropFilter(
//                               filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                               child: Container(
//                                 padding: const EdgeInsets.all(20),
//                                 decoration: BoxDecoration(
//                                   color: AppColors.black.withAlpha(
//                                     (30).toInt(),
//                                   ),
//                                   borderRadius: BorderRadius.circular(25.0),
//                                 ),
//                                 child: Column(
//                                   children: <Widget>[
//                                     SizedBox(
//                                       height: screenHeight * 0.5,
//                                       child: ListView.builder(
//                                         itemCount: list.length,
//                                         itemBuilder: (context, index) {
//                                           return ListTile(
//                                             contentPadding:
//                                                 const EdgeInsets.all(8.0),
//                                             leading: const Image(
//                                               image: AssetImage(
//                                                 AssetsPaths.fitnessAppIcon,
//                                               ),
//                                             ),
//                                             title: Text(
//                                               'Bensh Press',
//                                               style: theme.textTheme.bodyLarge
//                                                   ?.copyWith(fontSize: 18),
//                                             ),
//                                             subtitle: Text(
//                                               '3 groups * 15 times Lorem ipsum dolor sit  amet consectetur. Tempus ',
//                                               style: theme.textTheme.labelLarge,
//                                             ),
//                                             trailing: const Image(
//                                               image: AssetImage(
//                                                 AssetsPaths.playBtn,
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }
//
//           },
//           listener: (context, state) {
//             if(state.status==Status.loading){
//               return loadingAlert();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
//
// Widget _infoChip(String label, {Color bgColor = Colors.transparent}) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//     decoration: BoxDecoration(
//       color: bgColor,
//       border: Border.all(color: Colors.white),
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: Text(
//       label,
//       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//     ),
//   );
// }
// Widget loadingAlert(){
//   return const LoadingStateWidget();
// }


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
            } else if (state.status == Status.success) {
              print('lllscreen${state.exercises.length}');
              displaySnackBar(
                contentType: ContentType.success,
                title: 'Success',
                message: 'Exercises loaded successfully',
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
                                child: Image.asset(
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
                                      's',
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          return ListTile(
                                            contentPadding:
                                            const EdgeInsets.all(8.0),
                                            leading: const Image(
                                              image: AssetImage(
                                                AssetsPaths.fitnessAppIcon,
                                              ),
                                            ),
                                            title: Text(
                                              state.exercises[index].targetMuscleGroup ?? 'Exercise',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(fontSize: 18),
                                            ),
                                            subtitle: Text(
                                              '${state.exercises[index].difficultyLevel ?? ""}\n${state.exercises[index].targetMuscleGroup ?? ""}',
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
