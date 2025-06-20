import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';

class AiChatPage extends BaseStatelessWidget {
  const AiChatPage({super.key});

  @override
  Widget customBuild(BuildContext context, inherit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "AI Chat Page",
            style: inherit.theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
