import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/utilities/user_provider/user_provider.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';
import 'package:super_fitness/modules/smart_coach/domain/use_cases/prompt_model_use_case.dart';
import 'package:super_fitness/modules/smart_coach/ui/view_model/smart_coach_state.dart';

@injectable
class SmartCoachScreenViewModel extends Cubit<SmartCoachScreenState> {
  final PromptModelUseCase _promptModelUseCase;

  SmartCoachScreenViewModel(this._promptModelUseCase)
      : super(SmartCoachScreenState());

  final ChatHistoryModel chatHistoryModel = ChatHistoryModel(messages: []);

  void promptAiToSayWelcome() {
    var userInfo = getIt
        .get<UserProvider>()
        .userLoginInfo
        ?.user;
    chatHistoryModel.messages.addAll([
      MessageItem(
        role: MessageRoles.user,
        message:
        "You are a smart fitness coach. Help the user with gym workouts, nutrition, and motivation.",
      ),
      MessageItem(
        role: MessageRoles.user,
        message:
        userInfo?.firstName == null && userInfo?.lastName == null
            ? "Welcome User."
            : "Welcome User Named ${userInfo?.firstName ??
            userInfo?.lastName}.",
      ),
    ]);
  }

  void promptAiModel(String message) async {}
}

/*

    // Provide a prompt that contains text
    final prompt = [
      Content.text(
        "You are a smart fitness coach. Help the user with gym workouts, nutrition, and motivation.",
              Content.text("What's a good workout for building upper body strength"),
    ];

    // To generate text output, call generateContent with the text input
    final response = model.generateContentStream(prompt);

    await for (final chunk in response) {
      final text = chunk.text;
      // Append `text` to your chat UI as it arrives
      print(text); // or update your UI here
    }

 */