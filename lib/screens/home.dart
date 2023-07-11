import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final dio = Dio();
  List<dynamic> quotes = [];
  int quotesSize = 0;
  Map<String, dynamic> currentQuote = {
    "phrase": "Loading...",
    "author": "Loading...",
  };

  @override
  void initState() {
    super.initState();
    retrieveQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 200, height: 200),
            Text(
              currentQuote["phrase"],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                currentQuote["author"],
                style: const TextStyle(
                  color: Colors.white,
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
                      'assets/images/share.png',
                      width: 50,
                      height: 50,
                    ),
                    onPressed: () {
                      Share.share(
                        '${currentQuote["phrase"]} - ${currentQuote["author"]}',
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
                        color: isLiked ? const Color(0xffE91E63) : Colors.white,
                        size: 35,
                      );
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/regenerate.png',
                    width: 50,
                    height: 50,
                  ),
                  onPressed: () {
                    retrieveQuotes();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> retrieveQuotes() async {
    setState(() {
      currentQuote = {
        "phrase": "Loading...",
        "author": "Loading...",
      };
    });

    final response = await dio.get('http://192.168.1.71:8080/api/v1/quote');
    setState(() {
      quotes = response.data;
      quotesSize = quotes.length;
      // Get a random quote
      final random = Random();
      currentQuote = quotes[random.nextInt(quotesSize)];
    });
  }
}
