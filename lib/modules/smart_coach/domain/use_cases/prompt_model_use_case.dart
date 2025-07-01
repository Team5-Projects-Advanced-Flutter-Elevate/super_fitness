import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';
import 'package:super_fitness/modules/smart_coach/domain/repositories_contracts/ai_model_repo.dart';
import 'package:super_fitness/modules/smart_coach/domain/result/ai_model_result.dart';

@injectable
class PromptModelUseCase {
  final AiModelRepo _aiModelRepo;

  PromptModelUseCase(this._aiModelRepo);

  AiModelResult call({
    required ChatHistoryModel chatHistoryModel,
  }) {
    return _aiModelRepo.promptModel(chatHistoryModel: chatHistoryModel);
  }
}
