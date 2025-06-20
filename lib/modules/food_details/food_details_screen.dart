import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/modules/food_details/view_model/food_details_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../core/bases/base_stateful_widget_state.dart';
import '../../core/colors/app_colors.dart';
import '../../core/constants/assets_paths/assets_paths.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState
    extends BaseStatefulWidgetState<FoodDetailsScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(
            "https://www.youtube.com/watch?v=z8w0zNS_Y1o&ab_channel=Saba7oKorah-%D8%B5%D8%A8%D8%A7%D8%AD%D9%88%D9%83%D9%88%D8%B1%D8%A9",
          )!,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodDetailsCubit(),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPaths.homeBg),
            fit: BoxFit.cover,
          ),
        ),

        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 5,
                child: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
                  builder: (context, state) {
                    switch (state.foodVideoStatus) {
                      case FoodVideoStatus.playing:
                        return YoutubePlayerBuilder(
                          player: YoutubePlayer(
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
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        "assets/images/food.jpg",
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
                                      colors: [
                                        Colors.transparent,
                                        AppColors.black,
                                      ],
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
                              left: 16, // Add some horizontal positioning
                              right: 16,
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Pasta with meat',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(fontSize: 24),
                                    ),
                                    const Text(
                                      'Lorem ipsum dolor sit amet consectetur. Tempus volutpat ut nisi morbi. Lorem ipsum dolor sit amet consectetur. Tempus volutpat ut nisi morbi.',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  4,
                                  (index) => Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.white,
                                      ),
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
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
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
                              top: 0,
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<FoodDetailsCubit>(
                                    context,
                                  ).updateVideoState(true);
                                },
                                icon: Icon(Icons.play_arrow, size: 90),
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
                flex: 3,
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
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
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
                                          'data',
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(fontSize: 16),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '250',
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                                color: AppColors.mainColorDark,
                                              ),
                                        ),
                                      ],
                                    ),
                                separatorBuilder:
                                    (context, index) =>
                                        const Divider(color: Color(0xFF2D2D2D)),
                                itemCount: 5,
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
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 22,
                  ),
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
          ),
        ),
      ),
    );
  }
}
