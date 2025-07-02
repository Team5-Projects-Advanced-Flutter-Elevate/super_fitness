import 'package:injectable/injectable.dart';

import '../repositories_contracts/chat_fire_store_repo.dart';

@injectable
class UpdateChatTimeUseCase {
  final ChatFireStoreRepo _chatRepo;

  UpdateChatTimeUseCase(this._chatRepo);

  Future<void> call({required String userId, required String chatId}) async {
    await _chatRepo.updateChatTime(userId, chatId);
  }
}
