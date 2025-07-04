import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:injectable/injectable.dart';

@module
abstract class GeminiModelProvider {
  @lazySingleton
  GenerativeModel provide() {
    return FirebaseAI.googleAI(
      appCheck: FirebaseAppCheck.instance,
    ).generativeModel(model: 'gemini-2.5-flash');
  }
}
