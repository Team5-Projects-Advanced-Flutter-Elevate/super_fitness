import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';
import 'package:super_fitness/modules/smart_coach/domain/result/ai_model_result.dart';

abstract interface class AiModelRepo {
  AiModelResult promptModel({required ChatHistoryModel chatHistoryModel});

}