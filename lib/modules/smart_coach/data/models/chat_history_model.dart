import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatHistoryModel extends Equatable {
  // ignore_for_file: must_be_immutable

  String? id;
  String? title;
  List<MessageItem> messages;
  int? createdAt; // Epoch timestamp
  int? lastUpdateAt; // Epoch timestamp
  bool? didChatEnded;

  ChatHistoryModel({
    this.id,
    this.title,
    required this.messages,
    this.createdAt,
    this.lastUpdateAt,
    this.didChatEnded,
  });

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'messages': messages.map((msg) => msg.toFireStore()).toList(),
      'createdAt': createdAt,
      'lastUpdateAt': lastUpdateAt,
      'didChatEnded': didChatEnded,
    };
  }

  factory ChatHistoryModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return ChatHistoryModel(
      id: snapshot.id,
      title: data['title'] ?? 'Untitled Chat',
      messages:
          (data['messages'] as List<dynamic>)
              .map((msg) => MessageItem.fromFireStore(msg))
              .toList(),
      didChatEnded: data['didChatEnded'],
        createdAt: data['createdAt'],
        lastUpdateAt: data['lastUpdateAt']
    );
  }

  @override
  List<Object?> get props =>
      [id, title, messages, createdAt, lastUpdateAt, didChatEnded];

  @override
  String toString() =>
      "id: $id,title: $title,messages: $messages,createdAt: $createdAt,lastUpdatedAt $lastUpdateAt,didChatEnded: $didChatEnded";
}

class MessageItem extends Equatable {
  final MessageRoles role;
  String message;

  MessageItem({required this.role, required this.message});

  Map<String, dynamic> toFireStore() {
    return {
      'role': role.name, // Store enum as string
      'message': message,
    };
  }

  factory MessageItem.fromFireStore(Map<String, dynamic> data) {
    return MessageItem(
      role: MessageRoles.values.byName(
        data['role'],
      ), // Convert string back to enum
      message: data['message'],
    );
  }

  @override
  List<Object?> get props => [role, message];

  @override
  String toString() => "$role, $message";

  MessageItem copyWith({MessageRoles? role, String? message}) {
    return MessageItem(
      role: role ?? this.role,
      message: message ?? this.message,
    );
  }
}

enum MessageRoles { user, model }
