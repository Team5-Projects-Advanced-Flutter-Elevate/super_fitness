import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/ui/view_model/profile_cubit.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/ui/widgets/success_state.dart';
import '../../../../../../core/widgets/error_state_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseStatefulWidgetState<ProfilePage> {
  late ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = BlocProvider.of<ProfileCubit>(context);
    profileCubit.doIntent(GetProfileDataIntent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.profile), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            switch (state.status) {
              case ProfileStatus.initial:
              case ProfileStatus.loading:
                return const LoadingStateWidget();
              case ProfileStatus.success:
                return SuccessState(state: state, cubit: profileCubit);
              case ProfileStatus.error:
                return ErrorStateWidget(error: state.getProfileError!);
            }
          },
        ),
      ),
    );
  }
}
