import 'package:charm_bot/utility/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _Bookmarks();
}

class _Bookmarks extends State<Bookmarks> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(AppLocalizations.of(context)!.bookmarksTitle),
      ),
      body: Container(
        width: double.infinity,
        height: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Text(
          'Bookmarks',
        ),
      ),
    );
  }
}
