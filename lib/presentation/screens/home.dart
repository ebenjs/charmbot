import 'dart:convert';
import 'dart:math';

import 'package:charm_bot/business_logic/cubits/cubit/bookmarks_cubit.dart';
import 'package:charm_bot/presentation/pages/bookmarks.dart';
import 'package:charm_bot/presentation/screens/theme_screen.dart';
import 'package:charm_bot/utility/theme_computing.dart';
import 'package:charm_bot/utility/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../business_logic/cubits/cubit/get_quotes_cubit.dart';
import '../../data/models/quote.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> with ThemeScreen {
  Quote currentQuote = Quote(phrase: '', author: '');

  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetQuotesCubit>(context).load();
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
        backgroundColor:
            ThemeComputing.getThemeSpecificPrimaryColor(brightness),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark,
                color:
                    ThemeComputing.getThemeSpecificSecondaryColor(brightness)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Bookmarks()),
              );
            },
          ),
          // theme button
          IconButton(
            icon: Icon(Icons.brightness_4,
                color:
                    ThemeComputing.getThemeSpecificSecondaryColor(brightness)),
            onPressed: () {
              ThemeComputing.changeTheme(context);
              initializeTheme().then((value) {
                setState(() {
                  brightness = value;
                });
              });
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: ThemeComputing.getThemeSpecificPrimaryColor(brightness),
        ),
        child: BlocConsumer<GetQuotesCubit, GetQuotesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    "assets/images/${ThemeComputing.getThemeSpecificLogo(brightness)}",
                    width: 200,
                    height: 200),
                Text(
                  state.currentQuote.phrase,
                  style: TextStyle(
                    color: ThemeComputing.getThemeSpecificSecondaryColor(
                        brightness),
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    state.currentQuote.author,
                    style: TextStyle(
                      color: ThemeComputing.getThemeSpecificSecondaryColor(
                          brightness),
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // IconButton
                      IconButton(
                        icon: Image.asset(
                          "assets/images/${ThemeComputing.getThemeSpecificShareIcon(brightness)}",
                          width: 50,
                          height: 50,
                        ),
                        onPressed: () {
                          Share.share(
                            '${state.currentQuote.phrase} - ${state.currentQuote.author}',
                          );
                        },
                      ),
                      LikeButton(
                        size: 50,
                        circleColor: const CircleColor(
                            start: Color(0xffEC407A), end: Color(0xffE91E63)),
                        bubblesColor: const BubblesColor(
                          dotPrimaryColor: Color(0xffEC407A),
                          dotSecondaryColor: Color(0xffE91E63),
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            isLiked ? Icons.favorite : Icons.favorite_outline,
                            color: isLiked
                                ? const Color(0xffE91E63)
                                : ThemeComputing.getThemeSpecificSecondaryColor(
                                    brightness),
                            size: 35,
                          );
                        },
                        onTap: (bool isLiked) async {
                          if (isLiked) {
                            return false;
                          } else {
                            BlocProvider.of<BookmarksCubit>(context)
                                .addBookmark(state.currentQuote);
                            return true;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: ThemeComputing.getThemeSpecificSecondaryColor(
                          brightness),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        "assets/images/${ThemeComputing.getThemeSpecificRegenerateIcon(brightness)}",
                        width: 50,
                        height: 50,
                      ),
                      onPressed: () {
                        BlocProvider.of<GetQuotesCubit>(context).load();
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Future<void> _initializeData() async {
  //   await ThemeComputing.getSpecificBrightness().then((value) {
  //     setState(() {
  //       brightness = value;
  //     });
  //   });
  // }
}
