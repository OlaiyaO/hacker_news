import 'package:flutter/material.dart';
import 'package:hacker_news/src/models/item_model.dart';
import '../blocs/comments_provider.dart';
import '../widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  const NewsDetail({Key? key, required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return const Text('Loading');
        }
        final itemFuture = snapshot.data![itemId];
        return FutureBuilder(
          future: itemFuture,
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return const Text('Loading');
            }
            return buildList(itemSnapshot.data!, snapshot.data!);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    final commentsList = item.kids!.map((kidCommentId) {
      return Comment(itemId: kidCommentId, itemMap: itemMap, depth: 0,);
    }).toList();
    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(10.0),
      child: Text(
        '${item.title}',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
