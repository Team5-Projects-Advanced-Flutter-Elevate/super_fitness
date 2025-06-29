import 'package:firebase_ai/firebase_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';
import 'package:super_fitness/modules/smart_coach/domain/repositories_contracts/ai_model_repo.dart';

@injectable
class PromptModelUseCase {
  final AiModelRepo _aiModelRepo;

  PromptModelUseCase(this._aiModelRepo);

  Stream<GenerateContentResponse> call({
    required ChatHistoryModel chatHistoryModel,
  }) {
    return _aiModelRepo.promptModel(chatHistoryModel: chatHistoryModel);
  }
}
