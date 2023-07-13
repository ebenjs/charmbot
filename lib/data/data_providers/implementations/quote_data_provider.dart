import 'package:charm_bot/utility/config.dart';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/quote.dart';
import '../interfaces/data_provider.dart';

class QuoteDataProvider implements DataProvider {
  static final dio = Dio();

  @override
  Future<List<dynamic>> readAll() async {
    final response = await dio.get('${Config.API_URL}/quote');
    return response.data;
  }

  @override
  readById(int id) {
    // TODO: implement readById
    throw UnimplementedError();
  }
}
