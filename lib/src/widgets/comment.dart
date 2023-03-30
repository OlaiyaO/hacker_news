import 'package:flutter/material.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  const Comment(
      {Key? key, required this.itemId, required this.itemMap, required this.depth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }

        final item = snapshot.data!;

        final children = <Widget>[
          ListTile(
            title: buildText(item),
            subtitle:
            item.by == '' ? const Text('deleted') : Text('${item.by}'),
            contentPadding: EdgeInsets.only(
                left: (depth + 1) * 16, right: 16.0),
          ),
          const Divider(),
        ];
        for (var kidId in item.kids!) {
          children.add(
            Comment(
              itemId: kidId,
              itemMap: itemMap,
              depth: depth + 1,
            ),
          );
        }

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel itemModel) {
    final text = itemModel.text!.replaceAll('&#x27;', ' \' ').replaceAll(
        '<p>', '\n\n').replaceAll('</p>', '');
    return Text(text);
  }
}
