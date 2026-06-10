import 'package:chat_app/data/datasource/ai_datasource.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiRemoteDataSourceImpl
    implements GeminiRemoteDataSource {

  final GenerativeModel model;

  GeminiRemoteDataSourceImpl(this.model);

  @override
  Future<String> sendMessage(String message) async {
    try {
      return await _generate(message);
    } catch (e) {

      // Retry once after 2 seconds
      await Future.delayed(
        const Duration(seconds: 2),
      );

      try {
        return await _generate(message);
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<String> _generate(String message) async {
    final response = await model.generateContent([
      Content.text(message),
    ]);

    return response.text ??
        'No response generated.';
  }
}