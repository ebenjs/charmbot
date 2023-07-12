import 'package:bloc/bloc.dart';
import 'package:charm_bot/data/models/quote.dart';
import 'package:charm_bot/data/repositories/quote_repository.dart';
import 'package:meta/meta.dart';

part 'get_quotes_state.dart';

class GetQuotesCubit extends Cubit<GetQuotesState> {
  GetQuotesCubit()
      : super(GetQuotesInitial(
            status: 0, currentQuote: Quote(phrase: '', author: '')));

  void _isLoading() {
    Quote currentQuote = Quote(phrase: 'Loading...', author: 'Loading...');
    emit(GetQuotesInitial(status: 1, currentQuote: currentQuote));
  }

  Future<void> load() async {
    _isLoading();
    Quote currentQuote = Quote(phrase: 'Loading...', author: 'Loading...');
    await QuoteRepository.getQuote().then((value) {
      currentQuote = value;
      emit(GetQuotesLoaded(status: 2, currentQuote: currentQuote));
    }).catchError((e) {
      _isError(e);
    });
  }

  void _isError(dynamic error) => emit(GetQuotesError(error: error, status: 3));

  void addBookmark(Quote quote) {
    QuoteRepository.addBookmark(quote).then((value) {
      emit(SaveQuoteToBookmarks(result: value, currentQuote: quote));
    }).catchError((e) {
      _isError(e);
    });
  }
}
