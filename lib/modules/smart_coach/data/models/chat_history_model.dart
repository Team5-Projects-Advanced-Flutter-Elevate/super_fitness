import 'package:equatable/equatable.dart';

class ChatHistoryModel extends Equatable {
  // ignore_for_file: must_be_immutable

  List<MessageItem> messages;

  bool didChatEnded;

  String title;

  ChatHistoryModel(
      {required this.messages, this.didChatEnded = false, this.title = ""});

  @override
  List<Object?> get props => [messages];
}

class MessageItem extends Equatable {
  MessageRoles role;
  String message;

  MessageItem({required this.role, required this.message});

  @override
  List<Object?> get props => [role, message];

  @override
  String toString() {
    return "$role, $message";
  }

  MessageItem copyWith({MessageRoles? role, String? message}) {
    return MessageItem(
        role: role ?? this.role,
        message: message ?? this.message
    );
  }
}

enum MessageRoles {
  user,
  model
}