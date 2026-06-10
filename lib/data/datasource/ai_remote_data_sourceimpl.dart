import 'package:chat_app/data/datasource/ai_datasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiRemoteDataSourceImpl
    implements GeminiRemoteDataSource {

  final GenerativeModel model;

  GeminiRemoteDataSourceImpl(this.model);

  @override
  Future<String> sendMessage(String message) async {
    try {
      print('Calling Gemini...');

      final response = await model.generateContent([
        Content.text(message),
      ]);

      debugPrint('Gemini response received');

      return response.text ?? 'No response generated.';
    } catch (e, stackTrace) {
      debugPrint('Gemini Error: $e');
      debugPrint(stackTrace.toString());

      rethrow;
    }
  }
}