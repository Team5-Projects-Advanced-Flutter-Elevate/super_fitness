import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/modules/smart_coach/ui/view_model/smart_coach_state.dart';

class SmartCoachScreenViewModel extends Cubit<SmartCoachScreenState> {
  SmartCoachScreenViewModel() : super(SmartCoachScreenState());

  static void callAiModel() async {
    // Initialize the Gemini Developer API backend service
    // Create a `GenerativeModel` instance with a model that supports your use case
    final model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.5-flash',
    );

    // Provide a prompt that contains text
    final prompt = [
      Content.text(
        "You are a smart fitness coach. Help the user with gym workouts, nutrition, and motivation.",
      ),
      Content.text("What's a good workout for building upper body strength"),
    ];

    // To generate text output, call generateContent with the text input
    final response = model.generateContentStream(prompt);

    await for (final chunk in response) {
      final text = chunk.text;
      // Append `text` to your chat UI as it arrives
      print(text); // or update your UI here
    }
  }
}
