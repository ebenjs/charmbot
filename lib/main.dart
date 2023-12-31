import 'package:charm_bot/business_logic/cubits/cubit/bookmarks_cubit.dart';
import 'package:charm_bot/business_logic/cubits/cubit/get_quotes_cubit.dart';
import 'package:charm_bot/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetQuotesCubit(),
        ),
        BlocProvider(
          create: (context) => BookmarksCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Charm Bot',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'OpenSans',
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          fontFamily: 'OpenSans',
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('fr'),
        ],
        home: const Home(),
      ),
    );
  }
}
