import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/constants/fire_base_constants.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/utilities/user_provider/user_provider.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';
import 'package:super_fitness/modules/smart_coach/domain/use_cases/add_list_of_messages_use_case.dart';
import 'package:super_fitness/modules/smart_coach/domain/use_cases/create_chat_use_case.dart';
import 'package:super_fitness/modules/smart_coach/domain/use_cases/end_chat_use_case.dart';
import 'package:super_fitness/modules/smart_coach/domain/use_cases/get_all_chats_use_case.dart';
import 'package:super_fitness/modules/smart_coach/domain/use_cases/prompt_model_use_case.dart';
import 'package:super_fitness/modules/smart_coach/domain/use_cases/update_chat_time_use_case.dart';
import 'package:super_fitness/modules/smart_coach/ui/view_model/smart_coach_state.dart';
import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';

@injectable
class SmartCoachScreenViewModel extends Cubit<SmartCoachScreenState> {
  final PromptModelUseCase _promptModelUseCase;
  final GetAllChatsUseCase _getAllChatsUseCase;
  final CreateChatUseCase _createChatUseCase;
  final AddListOfMessagesUseCase _addListOfMessagesUseCase;
  final UpdateChatTimeUseCase _updateChatTimeUseCase;
  final EndChatUseCase _endChatUseCase;

  SmartCoachScreenViewModel(
    this._promptModelUseCase,
    this._getAllChatsUseCase,
    this._createChatUseCase,
    this._addListOfMessagesUseCase,
    this._updateChatTimeUseCase,
    this._endChatUseCase,
  ) : super(const SmartCoachScreenState());

  ChatHistoryModel chatHistoryModel = ChatHistoryModel(messages: []);

  var userInfo = getIt.get<UserProvider>().userLoginInfo?.user;

  final TextEditingController textFieldController = TextEditingController();
  ValueNotifier<TextDirection?> textFieldTextDirectionNotifier = ValueNotifier(
    null,
  );
  ValueNotifier<bool> takeAnotherMessageNotifier = ValueNotifier(false);
  ValueNotifier<String> conversationTitleNotifier = ValueNotifier("");
  ValueNotifier<String> tokenNotifier = ValueNotifier("");
  ValueNotifier<bool> chatEndedNotifier = ValueNotifier(false);
  final ScrollController listViewOfChatsController = ScrollController();
  bool makeAiChatPageReloadPreviousConversations = false;
  bool makeThisScreenReloadPreviousConversations = false;

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
      case GetAllChats():
        _getAllChats();
        break;
      case UpdateTextFieldTextDirection():
        _updateTextDirection();
        break;
    }
  }

  void _initViewModel({required ChatHistoryModel chatHistoryModel}) {
    this.chatHistoryModel = chatHistoryModel;
    conversationTitleNotifier.value =
        (chatHistoryModel.title == FirebaseConstants.untitledChat)
            ? ""
            : this.chatHistoryModel.title;
    chatEndedNotifier.value = this.chatHistoryModel.didChatEnded;
    emit(
      SmartCoachScreenState(
        promptAiModelStatus: Status.success,
        messageItems: this.chatHistoryModel.messages,
      ),
    );
    takeAnotherMessageNotifier.value = true;
  }

  void _promptAiToSayWelcome() async {
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
                : appLocalizations.tellingGeminiToWelcomeUserWithInfo(
                  _getUserInfo(),
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
    var useCaseResult = await _promptModelUseCase.call(
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
        chatHistoryModel.messages.add(state.messageItems.last);
      },
      cancelOnError: true,
      onDone: () {
        takeAnotherMessageNotifier.value = true;
        chatHistoryModel.messages.add(state.messageItems.last);
      },
    );
  }

  Future<void> _getTitleFromUserFirstMessage(String firstMessage) async {
    AppLocalizations appLocalizations = getIt.get<AppLocalizations>();
    final Completer<void> doneCompleter = Completer<void>();
    var useCaseResult = await _promptModelUseCase.call(
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
    useCaseResult.responseStream.listen(
      (response) {
        titleStringBuffer.write(response.text);
      },
      cancelOnError: true,
      onError: (error) {
        conversationTitleNotifier.value = "";
        doneCompleter.complete();
      },
      onDone: () {
        chatHistoryModel.title = titleStringBuffer.toString();
        conversationTitleNotifier.value = titleStringBuffer.toString();
        doneCompleter.complete();
      },
    );
    await doneCompleter.future;
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
    _scrollToTheEndOfTheListAfterAddingAMessage();
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
      await _getTitleFromUserFirstMessage(message);
    }
    var useCaseResult = await _promptModelUseCase.call(
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
          _scrollToTheEndOfTheListAfterAddingAMessage();
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
        chatHistoryModel.messages.add(state.messageItems.last);
        _scrollToTheEndOfTheListAfterAddingAMessage();
        if (chatHistoryModel.id == null) {
          _createNewChat();
        } else {
          _onNewMessages();
        }
      },
      cancelOnError: true,
      onDone: () {
        takeAnotherMessageNotifier.value = true;
        chatHistoryModel.messages.add(state.messageItems.last);
        if (chatHistoryModel.id == null) {
          _createNewChat();
        } else {
          _onNewMessages();
        }
      },
    );
  }

  void _handleNumberOfTokensReached(int tokens) async {
    var userInfo = getIt.get<UserProvider>().userLoginInfo!.user;
    AppLocalizations appLocalizations = getIt.get<AppLocalizations>();
    if (tokens > 2000 && tokens < 3000) {
      tokenNotifier.value = appLocalizations.conversationIsCloseToLimit;
    } else if (tokens >= 3000) {
      tokenNotifier.value = appLocalizations.conversationEnded;
      chatHistoryModel.didChatEnded = true;
      chatEndedNotifier.value = true;
      await _endChatUseCase.call(
        userId: userInfo!.id!,
        chatId: chatHistoryModel.id!,
      );
    }
  }

  void _scrollToTheEndOfTheListAfterAddingAMessage() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listViewOfChatsController.animateTo(
        listViewOfChatsController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    });
  }

  String _getUserInfo() {
    AppLocalizations appLocalizations = getIt.get<AppLocalizations>();
    return {
      "name":
          userInfo?.firstName ?? userInfo?.lastName ?? appLocalizations.unknown,
      "age": userInfo?.age ?? appLocalizations.unknown,
      "gender": userInfo?.gender ?? appLocalizations.unknown,
      "height": userInfo?.height ?? appLocalizations.unknown,
      "weight": userInfo?.weight ?? appLocalizations.unknown,
      "activityLevel": userInfo?.activityLevel ?? appLocalizations.unknown,
      "goal": userInfo?.goal ?? appLocalizations.unknown,
    }.toString();
  }

  // Firestore Use Cases:
  void _getAllChats() async {
    emit(state.copyWith(getAllChatsStatus: Status.loading));
    var userInfo = getIt.get<UserProvider>().userLoginInfo?.user;
    var useCaseResult = await _getAllChatsUseCase.call(userInfo?.id ?? "");
    switch (useCaseResult) {
      case Success<List<ChatHistoryModel>>():
        emit(
          state.copyWith(
            getAllChatsStatus: Status.success,
            previousChats: useCaseResult.data,
          ),
        );
      case Error<List<ChatHistoryModel>>():
        emit(
          state.copyWith(
            getAllChatsStatus: Status.error,
            getAllChatsError: useCaseResult.error,
          ),
        );
    }
  }

  void _createNewChat() async {
    var userInfo = getIt.get<UserProvider>().userLoginInfo!.user;
    chatHistoryModel.createdAt = DateTime.now().millisecondsSinceEpoch;
    chatHistoryModel.lastUpdateAt = chatHistoryModel.createdAt;
    await _createChatUseCase.call(
      userId: userInfo!.id!,
      chatHistoryModel: chatHistoryModel,
    );
    debugPrint("###### ${chatHistoryModel.id}");
    makeAiChatPageReloadPreviousConversations = true;
    makeThisScreenReloadPreviousConversations = true;
  }

  void _onNewMessages() async {
    var userInfo = getIt.get<UserProvider>().userLoginInfo!.user;
    await _addListOfMessagesUseCase.call(
      userId: userInfo!.id!,
      chatId: chatHistoryModel.id!,
      messages: chatHistoryModel.messages.sublist(
        chatHistoryModel.messages.length - 2,
      ),
    );
    await _updateChatTimeUseCase.call(
      userId: userInfo.id!,
      chatId: chatHistoryModel.id!,
    );
    makeAiChatPageReloadPreviousConversations = true;
    makeThisScreenReloadPreviousConversations = true;
  }

  // Text Field of Messages:
  void _updateTextDirection() {
    final text = textFieldController.text;
    if (text.isEmpty) {
      textFieldTextDirectionNotifier.value = null;
      return;
    }

    final firstChar = text.characters.first;

    textFieldTextDirectionNotifier
        .value = determineTextDirectionBasedOnFirstLetter(firstChar);
  }

  TextDirection? determineTextDirectionBasedOnFirstLetter(String firstChar) {
    if (firstChar.isEmpty) return null;
    final isRtl = RegExp(
      r'^[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]',
    ).hasMatch(firstChar);
    return isRtl ? TextDirection.rtl : TextDirection.ltr;
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

class GetAllChats extends SmartCoachScreenIntent {}

class UpdateTextFieldTextDirection extends SmartCoachScreenIntent {}

/*

  String userId = '';
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    fireStore
        .collection(FirebaseConstants.userCollection)
        .doc(userId)
        .collection(FirebaseConstants.chatCollection)
        .snapshots()
        .listen((snapshot) {
          for (var doc in snapshot.docs){
            doc.metadata.hasPendingWrites;
          }
    });


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
