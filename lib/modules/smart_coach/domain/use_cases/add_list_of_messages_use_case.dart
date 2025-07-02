import 'package:injectable/injectable.dart';

import '../../data/models/chat_history_model.dart';
import '../repositories_contracts/chat_fire_store_repo.dart';

@injectable
class AddListOfMessagesUseCase {
  final ChatFireStoreRepo _chatRepo;

  AddListOfMessagesUseCase(this._chatRepo);

  Future<void> call({
    required String userId,
    required String chatId,
    required List<MessageItem> messages,
  }) async {
    await _chatRepo.addListOfMessages(
      userId: userId,
      chatId: chatId,
      messages: messages,
    );
  }
}
