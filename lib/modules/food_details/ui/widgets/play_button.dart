
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/food_details_cubit.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      bottom: 130,
      right: 130,
      left: 130,
      child: IconButton(
        onPressed: () {
          BlocProvider.of<FoodDetailsCubit>(
            context,
          ).doIntent(UpdateVideoStateIntent(true));
        },
        icon: const Icon(Icons.play_arrow, size: 90),
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ),
    );
  }
}
