import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/articles/article_bloc.dart';
import 'package:miniblog/repositories/article_repository.dart';
import 'package:miniblog/screens/homepage.dart';
import 'package:miniblog/themes/dark_theme.dart';
import 'package:miniblog/themes/light_theme.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  ThemeMode themeMode = ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    //_readThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ArticleBloc(articleRepository: ArticleRepository()),
        child: MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: const Homepage(),
        ));
  }
}
