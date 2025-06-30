import 'package:equatable/equatable.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';

enum Status { idle, loading, success, error }

class SmartCoachScreenState extends Equatable {
  final Status promptAiModelStatus;

  final List<MessageItem> messageItems;
  final Object? promptAiModelError;

  const SmartCoachScreenState({
    this.promptAiModelStatus = Status.idle,
    this.messageItems = const [],
    this.promptAiModelError,
  });
  @override
  List<Object?> get props => [
    promptAiModelStatus,
    promptAiModelError,
    messageItems,
  ];

  SmartCoachScreenState copyWith({
    Status? promptAiModelStatus,
    List<MessageItem>? messageItems,
    Object? promptAiModelError,
  }) {
    return SmartCoachScreenState(
      promptAiModelStatus: promptAiModelStatus ?? this.promptAiModelStatus,
      messageItems: messageItems ?? this.messageItems,
      promptAiModelError: promptAiModelError ?? this.promptAiModelError,
    );
  }
}
