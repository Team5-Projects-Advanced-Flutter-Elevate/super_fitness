import 'package:firebase_ai/firebase_ai.dart';
import 'package:injectable/injectable.dart';

@module
abstract class GeminiModelProvider {
  @lazySingleton
  GenerativeModel provide() {
    return FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');
  }
}
