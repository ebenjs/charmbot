part of 'get_quotes_cubit.dart';

@immutable
abstract class GetQuotesState {
  final Quote currentQuote;
  GetQuotesState({required this.currentQuote});
}

class GetQuotesInitial extends GetQuotesState {
  final int status;

  GetQuotesInitial({required this.status, required currentQuote})
      : super(currentQuote: currentQuote);
}

class GetQuotesLoaded extends GetQuotesState {
  final int status;

  GetQuotesLoaded({required this.status, required currentQuote})
      : super(currentQuote: currentQuote);
}

class GetQuotesError extends GetQuotesState {
  final int status;
  final dynamic error;

  GetQuotesError({required this.error, required this.status})
      : super(currentQuote: Quote(phrase: '', author: ''));
}

class SaveQuoteToBookmarks extends GetQuotesState {
  final int result;
  SaveQuoteToBookmarks({required this.result, required currentQuote})
      : super(currentQuote: currentQuote);
}
