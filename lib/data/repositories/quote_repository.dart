import 'dart:math';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../data_providers/quote_data_provider.dart';
import '../models/quote.dart';

class QuoteRepository {
  static Future<List<Quote>> getQuotes() async {
    List<dynamic> quotes = await QuoteDataProvider.fetchQuotes();
    return quotes.map((quote) => Quote.fromJson(quote)).toList();
  }

  static Future<Quote> getQuote() async {
    final response = await QuoteDataProvider.fetchQuotes();
    final random = Random();
    return Quote.fromJson(response[random.nextInt(response.length)]);
  }

  static Future<int> addBookmark(Quote quote) async {
    // using Isar database
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [QuoteSchema],
      directory: dir.path,
    );

    await isar.writeTxn(() async {
      await isar.quotes.put(quote);
    });

    final existingQuote = await isar.quotes.get(quote.id);

    return 0;
  }

  static Future<List<Quote>> getBookmarks() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [QuoteSchema],
      directory: dir.path,
    );

    final quotes = await isar.quotes.where().findAll();

    return quotes;
  }
}
