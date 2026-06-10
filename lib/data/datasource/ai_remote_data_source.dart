import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiRemoteDataSource {

  final GenerativeModel model;

  GeminiRemoteDataSource(String apiKey)
      : model = GenerativeModel(
    model: 'gemini-flash-latest',
    apiKey: apiKey,
  );

  Future<String> sendMessage(String message) async {

    final response = await model.generateContent(
      [
        Content.text(message),
      ],
    );

    return response.text ??'Sorry, I could not generate a response.';
  }
}