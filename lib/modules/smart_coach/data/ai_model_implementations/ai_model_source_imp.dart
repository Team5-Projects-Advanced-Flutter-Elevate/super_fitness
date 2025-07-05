import 'dart:async';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/smart_coach/data/ai_model_contracts/ai_model_source.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';
import 'package:super_fitness/modules/smart_coach/domain/result/ai_model_result.dart';

@Injectable(as: AiModelSource)
class AiModelSourceImp implements AiModelSource {
  final GenerativeModel _generativeModel;

  AiModelSourceImp(this._generativeModel);

  @override
  Future<AiModelResult> promptModel({
    required ChatHistoryModel chatHistoryModel,
  }) async {
    List<Content> prompt = [];
    int totalTokens = 0;
    for (var messageItem in chatHistoryModel.messages) {
      switch (messageItem.role) {
        case MessageRoles.user:
          prompt.add(Content.text(messageItem.message));
          totalTokens += (messageItem.message.length / 4).ceil();
          break;
        case MessageRoles.model:
          prompt.add(Content.model([TextPart(messageItem.message)]));
          totalTokens += (messageItem.message.length / 4).ceil();
          break;
      }
    }
    final StreamController<GenerateContentResponse> controller =
        StreamController();
    // We used the completer here to make teh stream awaits until onDone is called
    final Completer<void> doneCompleter = Completer<void>();
    var response = _generativeModel.generateContentStream(prompt);
    response.listen(
      (chunk) {
        if (chunk.text != null) {
          totalTokens += (chunk.text!.length / 4).ceil();
        }
        controller.add(chunk);
      },
      onDone: () {
        debugPrint("$totalTokens ================");
        controller.close();
        doneCompleter.complete();
      },
      onError: (error) {
        controller.addError(error);
        doneCompleter.complete();
      },
      cancelOnError: true,
    );
    await doneCompleter.future;
    return AiModelResult(
      numberOfToken: totalTokens,
      responseStream: controller.stream,
    );
  }
}
