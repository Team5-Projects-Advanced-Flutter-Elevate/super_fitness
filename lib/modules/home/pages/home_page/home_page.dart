import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';

class HomePage extends BaseStatelessWidget {
  const HomePage({super.key});

  @override
  Widget customBuild(BuildContext context, inherit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Home Page",
            style: inherit.theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
