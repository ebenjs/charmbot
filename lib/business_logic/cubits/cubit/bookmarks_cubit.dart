import 'package:bloc/bloc.dart';
import 'package:charm_bot/data/models/quote.dart';
import 'package:charm_bot/data/repositories/quote_repository.dart';
import 'package:flutter/material.dart';

part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  List<Quote> bookmarks = [];

  BookmarksCubit()
      : super(GetSavedQuotesToBookmarks(bookmarks: [], result: -1));

  void addBookmark(Quote quote) {
    QuoteRepository.addBookmark(quote).then((value) {
      emit(SaveQuoteToBookmarks(result: 0));
    });
  }

  void getBookmarks() {
    QuoteRepository.getBookmarks().then((value) {
      emit(
        GetSavedQuotesToBookmarks(
          bookmarks: value,
          result: 1,
        ),
      );
    });
  }

  void deleteBookmark(Quote quote) {
    QuoteRepository.deleteBookmark(quote).then((value) {
      emit(DeleteQuoteFromBookmarks(result: 0));
      getBookmarks();
    });
  }
}
