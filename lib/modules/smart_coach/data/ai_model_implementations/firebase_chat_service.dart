import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_history_model.dart';

class FirebaseChatService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Get user's chats collection with converter
  CollectionReference<ChatHistoryModel> _userChats(String userId) {
    return _fireStore
        .collection('Users')
        .doc(userId)
        .collection('SavedChats')
        .withConverter<ChatHistoryModel>(
          fromFirestore: ChatHistoryModel.fromFirestore,
          toFirestore: (chat, _) => chat.toFirestore(),
        );
  }

  // Create new chat
  Future<String> createChat(String userId, String title) async {
    final docRef = _userChats(userId).doc();
    await docRef.set(
      ChatHistoryModel(id: docRef.id, title: title, messages: []),
    );
    return docRef.id;
  }

  // Add message to chat
  Future<void> addMessage({
    required String userId,
    required String chatId,
    required MessageItem message,
  }) async {
    await _userChats(userId).doc(chatId).update({
      'messages': FieldValue.arrayUnion([message.toFireStore()]),
    });
  }

  // Get single chat
  Future<ChatHistoryModel?> getChat(String userId, String chatId) async {
    final doc = await _userChats(userId).doc(chatId).get();
    return doc.data();
  }

  // Get all user chats
  Future<List<ChatHistoryModel>> getChats(String userId) async {
    final snapshot = await _userChats(userId).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
