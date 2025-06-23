import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/complete_register.dart';
import 'package:super_fitness/modules/authentication/ui/complete_register/view_model/complete_register_cubit.dart';
import 'package:super_fitness/modules/authentication/ui/register/register_screen.dart';
import 'package:super_fitness/modules/authentication/ui/register/view_model/register_view_model.dart';

class AllRegisterFeature extends StatefulWidget {
  const AllRegisterFeature({super.key});

  @override
  State<AllRegisterFeature> createState() => _AllRegisterFeatureState();
}

class _AllRegisterFeatureState extends State<AllRegisterFeature> {
  RegisterViewModel registerViewModel = getIt.get<RegisterViewModel>();
  CompleteRegisterCubit completeRegisterCubit =
      getIt.get<CompleteRegisterCubit>();

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [const RegisterScreen(), const CompleteRegister()];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => registerViewModel),
        BlocProvider(create: (context) => completeRegisterCubit),
      ],
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: registerViewModel.pageViewController,
        children: screens,
      ),
    );
  }
}
