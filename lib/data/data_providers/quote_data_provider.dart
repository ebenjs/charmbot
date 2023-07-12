import 'package:dio/dio.dart';

class QuoteDataProvider {
  static final dio = Dio();

  static Future<List<dynamic>> fetchQuotes() async {
    final response = await dio.get('http://192.168.1.71:8080/api/v1/quote');
    return response.data;
  }
}
