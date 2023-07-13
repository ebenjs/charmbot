part of 'bookmarks_cubit.dart';

@immutable
abstract class BookmarksState {
  final List<Quote> bookmarks;
  BookmarksState({required this.bookmarks});
}

class SaveQuoteToBookmarks extends BookmarksState {
  final int result;
  SaveQuoteToBookmarks({required this.result}) : super(bookmarks: []);
}

class GetSavedQuotesToBookmarks extends BookmarksState {
  final int result;
  final List<Quote> bookmarks;
  GetSavedQuotesToBookmarks({required this.bookmarks, required this.result})
      : super(bookmarks: bookmarks);
}

// delete

class DeleteQuoteFromBookmarks extends BookmarksState {
  final int result;
  DeleteQuoteFromBookmarks({required this.result}) : super(bookmarks: []);
}
