import 'package:flutter/cupertino.dart';
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
    : super(const SmartCoachScreenState());

  final ChatHistoryModel chatHistoryModel = ChatHistoryModel(messages: []);

  var userInfo = getIt.get<UserProvider>().userLoginInfo?.user;
  ValueNotifier<bool> takeAnotherMessageNotifier = ValueNotifier(false);
  ValueNotifier<String> conversationTitleNotifier = ValueNotifier("");

  ValueNotifier<String> tokenNotifier = ValueNotifier("");

  bool reachedTokenLimit = false;

  void doIntent(SmartCoachScreenIntent intent) {
    if (reachedTokenLimit) return;
    switch (intent) {
      case PromptAiToWelcomeUser():
        _promptAiToSayWelcome();
        break;
      case PromptAiToAnswerUser():
        _promptAiModelToAnswerUser(intent.message);
        break;
    }
  }

  void _promptAiToSayWelcome() {
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
                ? "Welcome user briefly Just a few sentences. For every response, keep the answer simple, clear, and concise—no long explanations"
                : "Welcome user named ${userInfo?.firstName ?? userInfo?.lastName} briefly Just a few sentences. For every response, keep the answer simple, clear, and concise—no long explanations",
      ),
    ]);
    List<MessageItem> currentMessageItems =
        chatHistoryModel.messages.map((e) => e.copyWith()).toList();
    currentMessageItems.add(MessageItem(role: MessageRoles.model, message: ""));
    takeAnotherMessageNotifier.value = false;
    emit(
      SmartCoachScreenState(
        promptAiModelStatus: Status.loading,
        messageItems: currentMessageItems,
      ),
    );
    var useCaseResult = _promptModelUseCase.call(
      chatHistoryModel: chatHistoryModel,
    );
    _handleNumberOfTokensReached(useCaseResult.numberOfToken);
    useCaseResult.responseStream.listen(
      (response) {
        if (response.text != null) {
          var newMessageItems =
              state.messageItems.map((e) => e.copyWith()).toList();
          newMessageItems.last.message += response.text!;
          emit(
            state.copyWith(
              promptAiModelStatus: Status.success,
              messageItems: newMessageItems,
            ),
          );
        } else {
          emit(state.copyWith(promptAiModelStatus: Status.success));
        }
      },
      onError: (error) {
        var newMessagesItem =
            state.messageItems.map((e) => e.copyWith()).toList();
        newMessagesItem.last.message = "Something Went Wrong";
        emit(
          state.copyWith(
            promptAiModelStatus: Status.error,
            messageItems: newMessagesItem,
            promptAiModelError: error,
          ),
        );
        takeAnotherMessageNotifier.value = true;
      },
      cancelOnError: true,
      onDone: () {
        print("in onDone:of sayWelcome");
        takeAnotherMessageNotifier.value = true;
        chatHistoryModel.messages.add(state.messageItems.last);
      },
    );
  }

  void _getTitleFromUserFirstMessage(String firstMessage) async {
    var useCaseResult = _promptModelUseCase.call(
      chatHistoryModel: ChatHistoryModel(
        messages: [
          MessageItem(
            role: MessageRoles.user,
            message:
                "Give a short, 10-20 characters (not more) title for this message: $firstMessage, don't give me options just choose the best one.",
          ),
        ],
      ),
    );
    final StringBuffer titleStringBuffer = StringBuffer();
    _handleNumberOfTokensReached(useCaseResult.numberOfToken);
    useCaseResult.responseStream.listen(
      (response) {
        titleStringBuffer.write(response.text);
      },
      cancelOnError: true,
      onError: (error) {
        conversationTitleNotifier.value = "";
      },
      onDone: () {
        conversationTitleNotifier.value = titleStringBuffer.toString();
      },
    );
  }

  void _promptAiModelToAnswerUser(String message) async {
    chatHistoryModel.messages.add(
      MessageItem(role: MessageRoles.user, message: message),
    );
    List<MessageItem> currentMessageItems =
        chatHistoryModel.messages.map((e) => e.copyWith()).toList();
    emit(
      SmartCoachScreenState(
        promptAiModelStatus: Status.idle,
        messageItems: currentMessageItems,
      ),
    );
    List<MessageItem> newMessageItems =
        chatHistoryModel.messages.map((e) => e.copyWith()).toList();
    newMessageItems.add(MessageItem(role: MessageRoles.model, message: ""));
    takeAnotherMessageNotifier.value = false;
    emit(
      SmartCoachScreenState(
        promptAiModelStatus: Status.loading,
        messageItems: newMessageItems,
      ),
    );
    if (conversationTitleNotifier.value.isEmpty) {
      _getTitleFromUserFirstMessage(message);
    }
    var useCaseResult = _promptModelUseCase.call(
      chatHistoryModel: chatHistoryModel,
    );
    _handleNumberOfTokensReached(useCaseResult.numberOfToken);
    useCaseResult.responseStream.listen(
      (response) {
        if (response.text != null) {
          var newMessageItems =
              state.messageItems.map((e) => e.copyWith()).toList();
          newMessageItems.last.message += response.text!;
          emit(
            state.copyWith(
              promptAiModelStatus: Status.success,
              messageItems: newMessageItems,
            ),
          );
        } else {
          emit(state.copyWith(promptAiModelStatus: Status.success));
        }
      },
      onError: (error) {
        var newMessagesItem =
            state.messageItems.map((e) => e.copyWith()).toList();
        newMessagesItem.last.message = "Something Went Wrong";
        emit(
          state.copyWith(
            promptAiModelStatus: Status.error,
            messageItems: newMessagesItem,
            promptAiModelError: error,
          ),
        );
        takeAnotherMessageNotifier.value = true;
      },
      cancelOnError: true,
      onDone: () {
        takeAnotherMessageNotifier.value = true;
        chatHistoryModel.messages.add(state.messageItems.last);
      },
    );
  }

  void _handleNumberOfTokensReached(int tokens) {
    if (tokens > 400_000) {
      tokenNotifier.value = "Conversation is about to reach the limit";
    } else if (tokens >= 500_000) {
      tokenNotifier.value = "Conversation Ended";
      reachedTokenLimit = true;
    }
  }
}

sealed class SmartCoachScreenIntent {}

class PromptAiToWelcomeUser extends SmartCoachScreenIntent {}

class PromptAiToAnswerUser extends SmartCoachScreenIntent {
  String message;

  PromptAiToAnswerUser({required this.message});
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
