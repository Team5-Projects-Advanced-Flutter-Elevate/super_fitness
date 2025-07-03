import 'package:firebase_ai/firebase_ai.dart';

class AiModelResult {
  int numberOfToken;
  Stream<GenerateContentResponse> responseStream;

  AiModelResult({required this.numberOfToken, required this.responseStream});
}
