import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/smart_coach/data/ai_model_contracts/ai_model_source.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';
import 'package:super_fitness/modules/smart_coach/domain/repositories_contracts/ai_model_repo.dart';
import 'package:super_fitness/modules/smart_coach/domain/result/ai_model_result.dart';

@Injectable(as: AiModelRepo)
class AiModelRepoImp implements AiModelRepo {
  final AiModelSource _aiModelSource;

  AiModelRepoImp(this._aiModelSource);

  @override
  Future<AiModelResult> promptModel({
    required ChatHistoryModel chatHistoryModel,
  }) async {
    return _aiModelSource.promptModel(chatHistoryModel: chatHistoryModel);
  }
}
