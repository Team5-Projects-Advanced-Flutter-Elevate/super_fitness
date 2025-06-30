import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/smart_coach/data/ai_model_contracts/ai_model_source.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';

@Injectable(as: AiModelSource)
class AiModelSourceImp implements AiModelSource {
  final GenerativeModel _generativeModel;

  AiModelSourceImp(this._generativeModel);

  @override
  Stream<GenerateContentResponse> promptModel({
    required ChatHistoryModel chatHistoryModel,
  }) {
    List<Content> prompt = [];
    int totalTokens = 0;
    for (var messageItem in chatHistoryModel.messages) {
      switch (messageItem.role) {
        case MessageRoles.user:
          prompt.add(Content.text(messageItem.message));
          totalTokens += (messageItem.message.length / 4).ceil();
        case MessageRoles.model:
          prompt.add(Content.model([TextPart(messageItem.message)]));
          totalTokens += (messageItem.message.length / 4).ceil();
      }
    }
    debugPrint("$totalTokens ================");
    return _generativeModel.generateContentStream(prompt);
  }
}
