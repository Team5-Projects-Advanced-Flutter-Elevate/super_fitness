import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/smart_coach/data/ai_model_contracts/chat_fire_store_data_source.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';

import '../../domain/repositories_contracts/chat_fire_store_repo.dart';

class ChatFireStoreRepoImp implements ChatFireStoreRepo {
  final ChatFireStoreDataSource _chatFireStoreDataSource;

  ChatFireStoreRepoImp(this._chatFireStoreDataSource);
  @override
  Future<void> addListOfMessages({
    required String userId,
    required String chatId,
    required List<MessageItem> messages,
  }) async {
    await _chatFireStoreDataSource.addListOfMessages(
      userId: userId,
      chatId: chatId,
      messages: messages,
    );
  }

  @override
  Future<void> addMessage({
    required String userId,
    required String chatId,
    required MessageItem message,
  }) async {
    await _chatFireStoreDataSource.addMessage(
      userId: userId,
      chatId: chatId,
      message: message,
    );
  }

  @override
  Future<ApiResult<String>> createChat(
    String userId,
    ChatHistoryModel chatHistoryModel,
  ) async {
    return await _chatFireStoreDataSource.createChat(userId, chatHistoryModel);
  }

  @override
  Future<void> endChat(String userId, String chatId) async {
    await _chatFireStoreDataSource.endChat(userId, chatId);
  }

  @override
  Future<ApiResult<List<ChatHistoryModel>>> getAllChats(String userId) {
    // TODO: implement getAllChats
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<ChatHistoryModel?>> getChat(String userId, String chatId) {
    // TODO: implement getChat
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<void>> updateChatTime(String userId, String chatId) {
    // TODO: implement updateChatTime
    throw UnimplementedError();
  }
}
