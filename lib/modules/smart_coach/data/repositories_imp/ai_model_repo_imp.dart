import 'dart:async';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/smart_coach/data/ai_model_contracts/ai_model_source.dart';
import 'package:super_fitness/modules/smart_coach/data/models/chat_history_model.dart';
import 'package:super_fitness/modules/smart_coach/domain/repositories_contracts/ai_model_repo.dart';

@Injectable(as: AiModelRepo)
class AiModelRepoImp implements AiModelRepo {
  final AiModelSource _aiModelSource;

  AiModelRepoImp(this._aiModelSource);

  @override
  Stream<GenerateContentResponse> promptModel({
    required ChatHistoryModel chatHistoryModel,
  }) {
    // TODO: cache chat history
    final StreamController<
        GenerateContentResponse> controller = StreamController();
    final StringBuffer stringBuffer = StringBuffer();
    _aiModelSource
        .promptModel(chatHistoryModel: chatHistoryModel)
        .listen(
          (chunk) {
            stringBuffer.write(chunk.text);
        controller.add(chunk);
      },
      onDone: () {
        debugPrint("===================");
        debugPrint(stringBuffer.toString());
        debugPrint("===================");
        controller.close();
      },
      onError: controller.addError,
      cancelOnError: true,
    );
    return controller.stream;
  }
}
