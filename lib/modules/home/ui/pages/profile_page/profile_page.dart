import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_statless_widget.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/modules/home/domain/use_cases/change_password/change_password_use_case.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/change_password_page.dart';
import 'package:super_fitness/modules/home/ui/view_model/change_password/change_password_view_model.dart';

class ProfilePage extends BaseStatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget customBuild(BuildContext context, inherit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, DefinedRoutes.changePasswordRoute,),
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
