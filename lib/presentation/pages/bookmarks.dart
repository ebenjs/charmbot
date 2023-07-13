import 'package:charm_bot/business_logic/cubits/cubit/bookmarks_cubit.dart';
import 'package:charm_bot/data/models/quote.dart';
import 'package:charm_bot/utility/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

import '../../utility/theme_computing.dart';
import '../screens/theme_screen.dart';
import '../widgets/bookmark_deletion_indicator.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _Bookmarks();
}

class _Bookmarks extends State<Bookmarks> with ThemeScreen {
  dynamic quotes = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookmarksCubit>(context).getBookmarks();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() {
        initializeTheme().then((value) {
          setState(() {
            brightness = value;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(
          color: ThemeComputing.getThemeSpecificSecondaryColor(brightness),
        ),
        title: Text(
          AppLocalizations.of(context)!.bookmarksTitle,
          style: TextStyle(
            color: ThemeComputing.getThemeSpecificSecondaryColor(brightness),
          ),
        ),
        backgroundColor:
            ThemeComputing.getThemeSpecificPrimaryColor(brightness),
      ),
      body: BlocConsumer<BookmarksCubit, BookmarksState>(
        listener: (context, state) {
          if (state is DeleteQuoteFromBookmarks) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Quote deleted!'),
            ));
          }
        },
        builder: (context, state) {
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: state.bookmarks.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(state.bookmarks[index].id.toString()),
                onDismissed: (direction) {
                  setState(() {
                    BlocProvider.of<BookmarksCubit>(context)
                        .deleteBookmark(state.bookmarks[index]);
                    state.bookmarks.removeAt(index);
                  });
                },
                background: BookmarkDeletionIndicator(),
                child: ListTile(
                  title: Text(state.bookmarks[index].phrase),
                  subtitle: Text(state.bookmarks[index].author),
                  onTap: () {
                    Share.share(
                      '${state.bookmarks[index].phrase} - ${state.bookmarks[index].author}',
                    );
                  },
                ),
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
