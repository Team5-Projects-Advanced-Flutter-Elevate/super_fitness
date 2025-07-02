import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/constants/fire_base_constants.dart';

import '../../../../core/apis/api_executor/api_executor.dart';
import '../../../../core/apis/api_result/api_result.dart';
import '../ai_model_contracts/chat_fire_store_data_source.dart';
import '../models/chat_history_model.dart';

@Injectable(as: ChatFireStoreDataSource)
class FirebaseChatDataSource implements ChatFireStoreDataSource {
  FirebaseChatDataSource();

  CollectionReference<ChatHistoryModel> _userChats(String userId) {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    return fireStore
        .collection(FireBaseConstants.userCollection)
        .doc(userId)
        .collection(FireBaseConstants.chatCollection)
        .withConverter<ChatHistoryModel>(
          fromFirestore: ChatHistoryModel.fromFireStore,
          toFirestore: (chat, _) => chat.toFireStore(),
        );
  }

  @override
  Future<ApiResult<String>> createChat(
    String userId,
    ChatHistoryModel chatHistoryModel,
  ) async {
    final apiResult = await ApiExecutor.executeApi(() async {
      final docRef = _userChats(userId).doc();
      chatHistoryModel.id = docRef.id;
      await docRef.set(chatHistoryModel);
      return docRef.id;
    });

    switch (apiResult) {
      case Success<String>():
        return Success(data: apiResult.data);
      case Error<String>():
        return Error(error: apiResult.error);
    }
  }

  @override
  Future<void> addMessage({
    required String userId,
    required String chatId,
    required MessageItem message,
  }) async {
    await ApiExecutor.executeApi(() async {
      await _userChats(userId).doc(chatId).update({
        FireBaseConstants.messages: FieldValue.arrayUnion([
          message.toFireStore(),
        ]),
      });
    });
  }

  @override
  Future<void> addListOfMessages({
    required String userId,
    required String chatId,
    required List<MessageItem> messages,
  }) async {
    await ApiExecutor.executeApi(() async {
      await _userChats(userId).doc(chatId).update({
        FireBaseConstants.messages: FieldValue.arrayUnion(
          messages.map((m) => m.toFireStore()).toList(),
        ),
      });
    });
  }

  @override
  Future<ApiResult<ChatHistoryModel?>> getChat(
    String userId,
    String chatId,
  ) async {
    final apiResult = await ApiExecutor.executeApi(() async {
      final doc = await _userChats(userId).doc(chatId).get();
      return doc.data();
    });

    switch (apiResult) {
      case Success<ChatHistoryModel?>():
        return Success(data: apiResult.data);
      case Error<ChatHistoryModel?>():
        return Error(error: apiResult.error);
    }
  }

  @override
  Future<ApiResult<List<ChatHistoryModel>>> getAllChats(String userId) async {
    final apiResult = await ApiExecutor.executeApi(() async {
      final snapshot =
          await _userChats(
            userId,
          ).orderBy(FireBaseConstants.lastUpdateAt, descending: true).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    });

    switch (apiResult) {
      case Success<List<ChatHistoryModel>>():
        return Success(data: apiResult.data);
      case Error<List<ChatHistoryModel>>():
        return Error(error: apiResult.error);
    }
  }

  @override
  Future<void> endChat(String userId, String chatId) async {
    await ApiExecutor.executeApi(() async {
      await _userChats(
        userId,
      ).doc(chatId).update({FireBaseConstants.didChatEnded: true});
    });
  }

  @override
  Future<ApiResult<void>> updateChatTime(String userId, String chatId) async {
    return await ApiExecutor.executeApi(() async {
      await _userChats(userId).doc(chatId).update({
        FireBaseConstants.lastUpdateAt: DateTime.now().millisecondsSinceEpoch,
      });
    });
  }
}
