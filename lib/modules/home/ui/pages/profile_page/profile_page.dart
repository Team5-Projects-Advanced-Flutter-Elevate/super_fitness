import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';
import 'package:super_fitness/modules/edit_profile/ui/screens/edit_profile_screen.dart';

class ProfilePage extends BaseStatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget customBuild(BuildContext context, inherit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: InkWell(
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) =>const EditProfileScreen(),));
            },
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
