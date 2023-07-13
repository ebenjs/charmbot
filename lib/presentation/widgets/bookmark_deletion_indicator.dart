import 'package:charm_bot/utility/config.dart';
import 'package:charm_bot/utility/theme_computing.dart';
import 'package:flutter/material.dart';

import '../screens/theme_screen.dart';

class BookmarkDeletionIndicator extends StatefulWidget {
  const BookmarkDeletionIndicator({Key? key}) : super(key: key);

  @override
  State<BookmarkDeletionIndicator> createState() =>
      _BookmarkDeletionIndicatorState();
}

class _BookmarkDeletionIndicatorState extends State<BookmarkDeletionIndicator>
    with ThemeScreen {
  @override
  void initState() {
    super.initState();
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Config.colors['danger'],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.delete,
            color: ThemeComputing.getThemeSpecificPrimaryColor(brightness),
          ),
          const SizedBox(width: 10),
          Text(
            'Swipe to delete',
            style: TextStyle(
              color: ThemeComputing.getThemeSpecificPrimaryColor(brightness),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
