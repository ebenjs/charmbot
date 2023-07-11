part of 'get_quotes_cubit.dart';

@immutable
abstract class GetQuotesState {
  final int status;
  final Quote currentQuote;
  GetQuotesState({required this.status, required this.currentQuote});
}

class GetQuotesInitial extends GetQuotesState {
  GetQuotesInitial({required int status, required Quote currentQuote})
      : super(status: status, currentQuote: currentQuote);
}

class GetQuotesLoaded extends GetQuotesState {
  GetQuotesLoaded({
    required int status,
    required Quote currentQuote,
  }) : super(status: status, currentQuote: currentQuote);
}

class GetQuotesError extends GetQuotesState {
  final dynamic error;
  GetQuotesError(this.error, {required int status})
      : super(status: status, currentQuote: Quote(phrase: '', author: ''));
}
