import 'package:flutter/material.dart';
import 'package:super_fitness/core/colors/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../core/bases/base_stateful_widget_state.dart';

class PlayerScreen extends StatefulWidget {
  final String url;

  const PlayerScreen({super.key, required this.url});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends BaseStatefulWidgetState<PlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _createController(widget.url);
  }

  YoutubePlayerController _createController(String url) {
    final videoId = YoutubePlayer.convertUrlToId(url);
    return YoutubePlayerController(
      initialVideoId: videoId??'',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false, loop: true),
    );
  }

  @override
  void didUpdateWidget(covariant PlayerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.url != widget.url) {
      final newVideoId = YoutubePlayer.convertUrlToId(widget.url)!;
      _controller.load(newVideoId);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Center(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: AppColors.mainColorLight,
              actionsPadding: const EdgeInsets.only(top: 14),
              progressColors: ProgressBarColors(
                playedColor: AppColors.mainColorDark,
                handleColor: AppColors.mainColorDark,
                bufferedColor: AppColors.mainColorDark,
                backgroundColor: AppColors.white,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
