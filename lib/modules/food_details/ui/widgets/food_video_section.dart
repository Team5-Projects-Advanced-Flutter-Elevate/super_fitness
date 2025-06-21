import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/modules/food_details/ui/widgets/play_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../core/bases/base_stateful_widget_state.dart';
import 'package:flutter/material.dart';
import '../../../../core/colors/app_colors.dart';
import '../view_model/food_details_cubit.dart';
import 'categories_row.dart';
import 'food_background.dart';
import 'food_title_and_description.dart';
import 'back_button.dart';

class FoodVideoSection extends StatefulWidget {
  const FoodVideoSection({super.key, required this.state});

  final FoodDetailsState state;

  @override
  State<FoodVideoSection> createState() => _FoodVideoSectionState();
}

class _FoodVideoSectionState extends BaseStatefulWidgetState<FoodVideoSection> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(
            widget.state.foodDetailsEntity?.mealEntity?.strYoutube ?? '',
          )!,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                        BlocProvider.of<FoodDetailsCubit>(
                          context,
                        ).doIntent(UpdateVideoStateIntent(false));
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
                  FoodBackground(state: state),
                  FoodTitleAndDescription(state: state),
                  const MyBackButton(),

                  /// dummy data because no data available in api
                  const CaloriesRow(),
                  const PlayButton(),
                ],
              );
          }
        },
      ),
    );
  }
}
