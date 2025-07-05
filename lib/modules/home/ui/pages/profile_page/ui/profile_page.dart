import 'package:flutter/material.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/ui/widgets/success_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseStatefulWidgetState<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.profile), centerTitle: true),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: SuccessState(),
      ),
    );
  }
}
