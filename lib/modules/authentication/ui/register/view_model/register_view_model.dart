import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/authentication/ui/register/view_model/register_state.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterState> {
  RegisterViewModel() : super(RegisterState());

  TextEditingController firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController();

  FocusNode firstNameNode = FocusNode(),
      lastNameNode = FocusNode(),
      emailNode = FocusNode(),
      passwordNode = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
}
