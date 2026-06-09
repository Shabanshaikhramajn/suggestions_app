import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;
  ApiClient() : dio = Dio(BaseOptions(baseUrl: "https://   ?page=1&limit=10"));
}
