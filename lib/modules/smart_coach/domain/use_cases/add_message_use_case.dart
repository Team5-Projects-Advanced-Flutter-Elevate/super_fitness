import 'package:injectable/injectable.dart';

import '../../data/models/chat_history_model.dart';
import '../repositories_contracts/chat_fire_store_repo.dart';

@injectable
class AddMessageUseCase {
  final ChatFireStoreRepo _chatRepo;

  AddMessageUseCase(this._chatRepo);

  Future<void> call({
    required String userId,
    required String chatId,
    required MessageItem message,
  }) async {
    await _chatRepo.addMessage(
      userId: userId,
      chatId: chatId,
      message: message,
    );
  }
}
