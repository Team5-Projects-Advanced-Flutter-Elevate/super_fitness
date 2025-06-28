import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';

class ProfilePage extends BaseStatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget customBuild(BuildContext context, inherit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: GestureDetector(
            onTap:
                () => Navigator.pushNamed(
                  context,
                  DefinedRoutes.changePasswordRoute,
                ),
            child: Text(
              "Profile Page",
              style: inherit.theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
