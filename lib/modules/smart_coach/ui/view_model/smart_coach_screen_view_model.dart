import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/utilities/user_provider/user_provider.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';
import 'package:super_fitness/modules/smart_coach/domain/use_cases/prompt_model_use_case.dart';
import 'package:super_fitness/modules/smart_coach/ui/view_model/smart_coach_state.dart';
import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';

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
  ValueNotifier<bool> chatEndedNotifier = ValueNotifier(false);

  void doIntent(SmartCoachScreenIntent intent) {
    switch (intent) {
      case InitViewModel():
        _initViewModel(chatHistoryModel: intent.chatHistoryModel);
        break;
      case PromptAiToWelcomeUser():
        _promptAiToSayWelcome();
        break;
      case PromptAiToAnswerUser():
        _promptAiModelToAnswerUser(intent.message);
        break;
    }
  }

  void _initViewModel({required ChatHistoryModel chatHistoryModel}) {
    conversationTitleNotifier.value = chatHistoryModel.title;
    chatEndedNotifier.value = chatHistoryModel.didChatEnded;
    emit(
      SmartCoachScreenState(
        promptAiModelStatus: Status.success,
        messageItems: chatHistoryModel.messages,
      ),
    );
    takeAnotherMessageNotifier.value = true;
  }

  void _promptAiToSayWelcome() {
    AppLocalizations appLocalizations = getIt.get<AppLocalizations>();
    chatHistoryModel.messages.addAll([
      MessageItem(
        role: MessageRoles.user,
        message: appLocalizations.tellingGeminiToBeSmartFitnessCoach,
      ),
      MessageItem(
        role: MessageRoles.user,
        message:
            userInfo?.firstName == null && userInfo?.lastName == null
                ? appLocalizations.tellingGeminiToWelcomeUser
                : appLocalizations.tellingGeminiToWelcomeUserNamed(
                  "${userInfo?.firstName ?? userInfo?.lastName}",
                ),
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
      (chunk) {
        if (chunk.text != null) {
          var newMessageItems =
              state.messageItems.map((e) => e.copyWith()).toList();
          newMessageItems.last.message += chunk.text!;
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
        newMessagesItem.last.message =
            getIt.get<AppLocalizations>().somethingWentWrong;
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

  void _getTitleFromUserFirstMessage(String firstMessage) async {
    AppLocalizations appLocalizations = getIt.get<AppLocalizations>();
    var useCaseResult = _promptModelUseCase.call(
      chatHistoryModel: ChatHistoryModel(
        messages: [
          MessageItem(
            role: MessageRoles.user,
            message: appLocalizations.tellingGeminiToGiveChatTitle(
              firstMessage,
            ),
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
        chatHistoryModel.title = titleStringBuffer.toString();
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
        newMessagesItem.last.message =
            getIt.get<AppLocalizations>().somethingWentWrong;
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
    AppLocalizations appLocalizations = getIt.get<AppLocalizations>();
    if (tokens > 400_000) {
      tokenNotifier.value = appLocalizations.conversationIsCloseToLimit;
    } else if (tokens >= 500_000) {
      tokenNotifier.value = appLocalizations.conversationEnded;
      chatHistoryModel.didChatEnded = true;
      chatEndedNotifier.value = true;
    }
  }
}

sealed class SmartCoachScreenIntent {}

class PromptAiToWelcomeUser extends SmartCoachScreenIntent {}

class PromptAiToAnswerUser extends SmartCoachScreenIntent {
  String message;

  PromptAiToAnswerUser({required this.message});
}

class InitViewModel extends SmartCoachScreenIntent {
  ChatHistoryModel chatHistoryModel;

  InitViewModel({required this.chatHistoryModel});
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
