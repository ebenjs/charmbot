import 'package:charm_bot/utility/config.dart';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/quote.dart';
import '../interfaces/data_provider.dart';

class BookmarksDataProvider implements DataProvider {
  @override
  Future<List<Quote>> readAll() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar =
        await Isar.open([QuoteSchema], directory: dir.path, name: "bookmark");

    final quotes = await isar.quotes.where().findAll();

    isar.close();

    return quotes;
  }

  @override
  readById(int id) {
    // TODO: implement readById
    throw UnimplementedError();
  }
}
