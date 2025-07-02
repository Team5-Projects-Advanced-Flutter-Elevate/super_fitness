import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatHistoryModel extends Equatable {
  final String? id;
  final String? title;
  List<MessageItem> messages;

  ChatHistoryModel({
     this.id,
     this.title,
    required this.messages,
  });

  // Convert to Firestore format
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'messages': messages.map((msg) => msg.toFireStore()).toList(),
      // Auto-set timestamp
    };
  }

  // Create from Firestore document
  factory ChatHistoryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return ChatHistoryModel(
      id: snapshot.id,
      title: data['title'] ?? 'Untitled Chat',
      messages:
          (data['messages'] as List<dynamic>)
              .map((msg) => MessageItem.fromFirestore(msg))
              .toList(),
    );
  }

  @override
  List<Object?> get props => [id, title, messages];
}

class MessageItem extends Equatable {
  final MessageRoles role;
   String message;

   MessageItem({required this.role, required this.message});

  // Convert to Firestore format
  Map<String, dynamic> toFireStore() {
    return {
      'role': role.name, // Store enum as string
      'message': message,
    };
  }

  // Create from Firestore data
  factory MessageItem.fromFirestore(Map<String, dynamic> data) {
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
