import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/widgets/error_state_widget.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/food_details/ui/view_model/food_details_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../core/bases/base_stateful_widget_state.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/constants/assets_paths/assets_paths.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState
    extends BaseStatefulWidgetState<FoodDetailsScreen> {
  late YoutubePlayerController _controller;
  FoodDetailsCubit foodDetailsCubit = getIt<FoodDetailsCubit>();

  @override
  void initState() {
    super.initState();
    foodDetailsCubit.doIntent(GetFoodDetailsIntent('52949'));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => foodDetailsCubit,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPaths.homeBg),
            fit: BoxFit.cover,
          ),
        ),

        child: Scaffold(
          body: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
            builder: (context, state) {
              switch (state.getFoodDetailsStatus) {
                case GetFoodDetailsStatus.initial:
                case GetFoodDetailsStatus.loading:
                  return const LoadingStateWidget();
                case GetFoodDetailsStatus.success:
                  return buildSuccess(state);
                case GetFoodDetailsStatus.error:
                  return ErrorStateWidget(error: state.getFoodDetailsError!);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildSuccess(FoodDetailsState state) {
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(
            state.foodDetailsEntity?.mealEntity?.strYoutube ?? '',
          )!,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
            builder: (context, state) {
              switch (state.foodVideoStatus) {
                case FoodVideoStatus.playing:
                  return YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      actionsPadding: const EdgeInsets.only(top: 14),
                      progressColors: ProgressBarColors(
                        playedColor: AppColors.mainColorDark,
                        handleColor: AppColors.mainColorDark,
                        bufferedColor: AppColors.mainColorDark,
                        backgroundColor: AppColors.white,
                      ),
                      progressIndicatorColor: AppColors.mainColorDark,
                      topActions: [
                        IconButton(
                          onPressed: () {
                            foodDetailsCubit.doIntent(
                              UpdateVideoStateIntent(false),
                            );
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                      controller: _controller,
                      showVideoProgressIndicator: true,
                    ),
                    builder: (context, player) => player,
                  );
                case FoodVideoStatus.notPlaying:
                  return Stack(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  state
                                          .foodDetailsEntity
                                          ?.mealEntity
                                          ?.strMealThumb ??
                                      '',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, AppColors.black],
                                stops: [0.0, 0.8],
                              ),
                            ),
                          ),
                        ],
                      ),

                      Positioned(
                        top: 40,
                        child: IconButton(
                          color: AppColors.white,
                          constraints: const BoxConstraints(
                            maxHeight: 25,
                            maxWidth: 25,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.mainColorLight,
                          ),
                          onPressed: () {},
                          icon: Transform.flip(
                            flipX: !localizationManager.isEnglish,
                            child: const ImageIcon(
                              AssetImage(AssetsPaths.backIcon),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 80,
                        left: 16,
                        // Add some horizontal positioning
                        right: 16,
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.foodDetailsEntity?.mealEntity?.strMeal ??
                                    '',
                                style: Theme.of(
                                  context,
                                ).textTheme.labelLarge?.copyWith(fontSize: 24),
                              ),
                              SizedBox(
                                height: 70,
                                child: SingleChildScrollView(
                                  child: Text(
                                    state
                                            .foodDetailsEntity
                                            ?.mealEntity
                                            ?.strInstructions ??
                                        '',
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            4,
                            (index) => Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.white),
                                borderRadius: BorderRadius.circular(22),
                              ),

                              child: Column(
                                children: [
                                  Text(
                                    "100 k",
                                    style: theme.textTheme.labelSmall,
                                  ),
                                  Text(
                                    "Energy",
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.mainColorDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        bottom: 130,
                        right: 130,
                        left: 130,
                        child: IconButton(
                          onPressed: () {
                            foodDetailsCubit.doIntent(
                              UpdateVideoStateIntent(true),
                            );
                          },

                          icon: const Icon(Icons.play_arrow, size: 90),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                              Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
              }
            },
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ingredients',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                      child: Container(
                        width: screenWidth,
                        color: AppColors.black.withAlpha(150),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder:
                              (context, index) => Row(
                                children: [
                                  Text(
                                    state.ingredients![index],
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    state.measures![index],
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: AppColors.mainColorDark,
                                    ),
                                  ),
                                ],
                              ),
                          separatorBuilder:
                              (context, index) =>
                                  const Divider(color: Color(0xFF2D2D2D)),
                          itemCount: state.ingredients!.length,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommendation',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder:
                        (context, index) => Container(
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.all(16),
                          width: screenWidth * 0.44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.mainColorDark,
                          ),
                          child: Text(
                            'data',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ),
                    separatorBuilder:
                        (context, index) => const SizedBox(width: 12),
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
