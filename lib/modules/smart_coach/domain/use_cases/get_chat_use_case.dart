import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../data/models/chat_history_model.dart';
import '../repositories_contracts/chat_fire_store_repo.dart';

@injectable
class GetChatUseCase {
  final ChatFireStoreRepo _chatRepo;

  GetChatUseCase(this._chatRepo);

  Future<ApiResult<ChatHistoryModel?>> call({
    required String userId,
    required String chatId,
  }) async {
    return await _chatRepo.getChat(userId, chatId);
  }
}
