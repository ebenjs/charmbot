import 'package:charm_bot/utility/config.dart';
import 'package:dio/dio.dart';

class QuoteDataProvider {
  static final dio = Dio();

  static Future<List<dynamic>> fetchQuotes() async {
    final response = await dio.get('${Config.API_URL}/quote');
    return response.data;
  }
}
