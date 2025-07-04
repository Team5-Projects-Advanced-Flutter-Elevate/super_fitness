import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../data/models/chat_history_model.dart';
import '../repositories_contracts/chat_fire_store_repo.dart';

@injectable
class GetAllChatsUseCase {
  final ChatFireStoreRepo _chatRepo;

  GetAllChatsUseCase(this._chatRepo);

  Future<ApiResult<List<ChatHistoryModel>>> call(String userId) async {
    return await _chatRepo.getAllChats(userId);
  }
}
