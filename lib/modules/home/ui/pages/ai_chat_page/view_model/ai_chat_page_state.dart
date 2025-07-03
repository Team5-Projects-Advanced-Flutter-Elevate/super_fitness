import 'package:equatable/equatable.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';

enum Status { idle, loading, success, error }

class AiChatPageState extends Equatable {
  final Status getAllChatsStatus;
  final List<ChatHistoryModel>? chats;
  final Object? getAllChatsError;

  const AiChatPageState({
    this.getAllChatsStatus = Status.idle,
    this.chats,
    this.getAllChatsError,
  });

  @override
  List<Object?> get props => [getAllChatsStatus, chats, getAllChatsError];
}
