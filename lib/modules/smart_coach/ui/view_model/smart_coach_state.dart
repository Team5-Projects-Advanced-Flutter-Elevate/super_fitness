import 'package:equatable/equatable.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';

enum Status { idle, loading, success, error }

class SmartCoachScreenState extends Equatable {
  final Status promptAiModelStatus;
  final Status getAllChatsStatus;
  final List<MessageItem> messageItems;
  final List<ChatHistoryModel> previousChats;
  final Object? promptAiModelError;
  final Object? getAllChatsError;

  const SmartCoachScreenState({
    this.promptAiModelStatus = Status.idle,
    this.getAllChatsStatus = Status.idle,
    this.messageItems = const [],
    this.previousChats = const [],
    this.promptAiModelError,
    this.getAllChatsError,
  });
  @override
  List<Object?> get props => [
    promptAiModelStatus,
    getAllChatsStatus,
    messageItems,
    previousChats,
    promptAiModelError,
    getAllChatsError
  ];

  SmartCoachScreenState copyWith({
    Status? promptAiModelStatus,
    Status? getAllChatsStatus,
    List<MessageItem>? messageItems,
    List<ChatHistoryModel>? previousChats,
    Object? promptAiModelError,
    Object? getAllChatsError
  }) {
    return SmartCoachScreenState(
      promptAiModelStatus: promptAiModelStatus ?? this.promptAiModelStatus,
        getAllChatsStatus: getAllChatsStatus ?? this.getAllChatsStatus,
      messageItems: messageItems ?? this.messageItems,
        previousChats: previousChats ?? this.previousChats,
      promptAiModelError: promptAiModelError ?? this.promptAiModelError,
        getAllChatsError: getAllChatsError ?? this.getAllChatsError
    );
  }
}
