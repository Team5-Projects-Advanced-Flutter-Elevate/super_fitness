import 'package:equatable/equatable.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';

enum Status { idle, loading, success, error }

class AiChatPageState extends Equatable {
  final Status gatAllChatsStatus;
  final List<ChatHistoryModel>? chats;
  final Object? gatAllChatsError;

  const AiChatPageState({
    this.gatAllChatsStatus = Status.idle,
    this.chats,
    this.gatAllChatsError,
  });

  @override
  List<Object?> get props => [gatAllChatsStatus, chats, gatAllChatsError];
}
