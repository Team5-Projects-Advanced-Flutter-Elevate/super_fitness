import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../data/models/chat_history_model.dart';
import '../repositories_contracts/chat_fire_store_repo.dart';

@injectable
class CreateChatUseCase {
  final ChatFireStoreRepo _chatRepo;

  CreateChatUseCase(this._chatRepo);

  Future<ApiResult<String>> call({
    required String userId,
    required ChatHistoryModel chatHistoryModel,
  }) async {
    return await _chatRepo.createChat(userId, chatHistoryModel);
  }
}
