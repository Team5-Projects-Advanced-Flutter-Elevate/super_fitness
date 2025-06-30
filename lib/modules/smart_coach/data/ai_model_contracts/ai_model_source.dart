import 'package:firebase_ai/firebase_ai.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';

abstract interface class AiModelSource {
  Stream<GenerateContentResponse> promptModel(
      {required ChatHistoryModel chatHistoryModel});
}