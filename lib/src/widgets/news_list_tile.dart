import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import '../screens/news_detail.dart';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  const NewsListTile({Key? key, required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data?[itemId],
          builder: (context, futureSnapshot) {
            if (!futureSnapshot.hasData) {
              return const LoadingContainer();
            }
            return buildTile(futureSnapshot.data!, context);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel item, BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
          title: Text(item.title!),
          subtitle: Text('${item.score} points'),
          trailing: Column(children: [
            Icon(Icons.comment, color:  Colors.brown[800],),
            Text('${item.descendants}')
          ],),
        ),
        const Divider(
          height: 8,
        ),
      ],
    );
  }
}
