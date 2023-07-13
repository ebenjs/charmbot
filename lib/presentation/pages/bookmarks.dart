import 'package:charm_bot/business_logic/cubits/cubit/bookmarks_cubit.dart';
import 'package:charm_bot/data/models/quote.dart';
import 'package:charm_bot/utility/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _Bookmarks();
}

class _Bookmarks extends State<Bookmarks> {
  dynamic quotes = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookmarksCubit>(context).getBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(AppLocalizations.of(context)!.bookmarksTitle),
      ),
      body: BlocConsumer<BookmarksCubit, BookmarksState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: state.bookmarks.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(state.bookmarks[index].phrase),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        },
      ),
    );
  }
}
