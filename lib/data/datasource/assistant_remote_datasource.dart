import 'package:chat_app/core/network/api_client.dart';

class AssistantRemoteDataSource {
  final ApiClient client;
  AssistantRemoteDataSource(this.client);

  // Future<Map<String, dynamic>> getSuggestions(int page, int limit) async {
  //   final response = await client.dio.get(
  //     EndPoints.suggestions,
  //     queryParameters: {"page": page, "limit": limit},
  //   );
  //   return response.data;
  // }
  //
  //
  //
  //  Future<String> sendMessage(String message)async {
  //   final resposne = await client.dio.post(
  //      EndPoints.chat,
  //      data: {"message" : message}
  //   );
  //
  //   return resposne.data['reply'];
  //  }

  // Future<List<ChatMessageModel>> getChatHistory() async {
  //   final response = await client.dio.get(EndPoints.history);
  //
  //   return (response.data['data'] as List)
  //       .map((json) => ChatMessageModel.fromJson(json))
  //       .toList();
  // }
  //
}
