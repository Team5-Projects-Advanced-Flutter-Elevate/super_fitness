import 'package:flutter/material.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/modules/authentication/ui/register/register_screen.dart';
import 'package:super_fitness/modules/authentication/ui/register/view_model/register_view_model.dart';

class AllRegisterFeature extends StatefulWidget {
  const AllRegisterFeature({super.key});

  @override
  State<AllRegisterFeature> createState() => _AllRegisterFeatureState();
}

class _AllRegisterFeatureState extends State<AllRegisterFeature> {
  final RegisterViewModel registerViewModel = getIt.get<RegisterViewModel>();
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [const RegisterScreen()];
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
