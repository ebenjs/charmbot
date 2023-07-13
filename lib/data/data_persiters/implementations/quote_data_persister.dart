import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/quote.dart';
import '../interfaces/data_persister.dart';

class QuoteDataPersister implements DataPersister<Future<Quote>, Quote> {
  @override
  Future<Quote> create(Quote quote) async {
    // using Isar database
    final dir = await getApplicationDocumentsDirectory();
    final isar =
        await Isar.open([QuoteSchema], directory: dir.path, name: "bookmark");

    await isar.writeTxn(() async {
      await isar.quotes.put(quote);
    });

    isar.close();
    return quote;
  }

  @override
  Future<Quote> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
