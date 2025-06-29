class ChatHistoryModel {
  List<MessageItem> messages;

  ChatHistoryModel({required this.messages});
}

class MessageItem {
  MessageRoles role;
  String message;

  MessageItem({required this.role, required this.message});
}

enum MessageRoles {
  user,
  model
}