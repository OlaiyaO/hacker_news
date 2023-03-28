import 'package:flutter/material.dart';
import 'package:hacker_news/src/screens/news_list.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    
    return StoriesProvider(
      child: const MaterialApp(
        title: 'News!',
        home: NewsList(),
      ),
    );
  }
}
