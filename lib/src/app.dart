import 'package:flutter/material.dart';
import 'package:hacker_news/src/screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News!',
          onGenerateRoute: routes,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color:  Colors.brown[800],
            ),
          ),
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();

          return const NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name!.replaceFirst('/', ''),);

          commentsBloc.fetchItemWithComments(itemId);
          return NewsDetail(
            itemId: itemId,
          );
        }
      );
    }
  }
}
