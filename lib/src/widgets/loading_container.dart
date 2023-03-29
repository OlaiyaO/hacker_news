import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        const Divider(
          height: 8,
        ),
      ],
    );
  }
  Widget buildContainer() {
    return Container(
      height: 24,
      width: 150,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(vertical: 10.0),
    );
  }
}
