import '../../../../core/apis/api_result/api_result.dart';
import '../../data/models/chat_history_model.dart';

abstract interface class ChatFireStoreRepo {
  Future<ApiResult<String>> createChat(
    String userId,
    ChatHistoryModel chatHistoryModel,
  );

  Future<void> addMessage({
    required String userId,
    required String chatId,
    required MessageItem message,
  });

  Future<void> addListOfMessages({
    required String userId,
    required String chatId,
    required List<MessageItem> messages,
  });

  Future<ApiResult<ChatHistoryModel?>> getChat(String userId, String chatId);

  Future<ApiResult<List<ChatHistoryModel>>> getAllChats(String userId);
  Future<void> updateChatTime(String userId, String chatId);
  Future<void> endChat(String userId, String chatId);
}
