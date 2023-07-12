import 'dart:math';

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
}
