import 'dart:math';

import 'package:charm_bot/data/data_persiters/implementations/quote_data_persister.dart';
import 'package:charm_bot/data/data_providers/implementations/bookmarks_data_provider.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../data_providers/implementations/quote_data_provider.dart';
import '../models/quote.dart';

class QuoteRepository {
  static Future<Quote> getQuote() async {
    final response = await QuoteDataProvider().readAll();
    final random = Random();
    return Quote.fromJson(response[random.nextInt(response.length)]);
  }

  static Future<Quote> addBookmark(Quote quote) async {
    await QuoteDataPersister().create(quote);
    return quote;
  }

  static Future<List<Quote>> getBookmarks() async {
    List<Quote> bookmarks = [];
    await BookmarksDataProvider().readAll().then((value) {
      bookmarks = value;
    });

    return bookmarks;
  }
}
