import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_history_model.dart';

class FirebaseChatService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  CollectionReference<ChatHistoryModel> _userChats(String userId) {
    return _fireStore
        .collection('Users')
        .doc(userId)
        .collection('SavedChats')
        .withConverter<ChatHistoryModel>(
          fromFirestore: ChatHistoryModel.fromFireStore,
          toFirestore: (chat, _) => chat.toFireStore(),
        );
  }

  Future<String> createChat(
    String userId,
    ChatHistoryModel chatHistoryModel,
  ) async {
    final docRef = _userChats(userId).doc();
    await docRef.set(chatHistoryModel);
    return docRef.id;
  }

  Future<void> addMessage({
    required String userId,
    required String chatId,
    required MessageItem message,
  }) async {
    await _userChats(userId).doc(chatId).update({
      'messages': FieldValue.arrayUnion([message.toFireStore()]),
    });
  }

  Future<void> addListOfMessages({
    required String userId,
    required String chatId,
    required List<MessageItem> messages,
  }) async {
    await _userChats(userId).doc(chatId).update({
      'messages': FieldValue.arrayUnion(
        messages.map((m) => m.toFireStore()).toList(),
      ),
    });
  }

  Future<ChatHistoryModel?> getChat(String userId, String chatId) async {
    final doc = await _userChats(userId).doc(chatId).get();
    return doc.data();
  }

  Future<List<ChatHistoryModel>> getAllChats(String userId) async {
    final snapshot =
        await _userChats(userId).orderBy('createdAt', descending: true).get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
