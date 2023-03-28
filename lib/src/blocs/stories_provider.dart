import 'package:flutter/material.dart';
import 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  // const StoriesProvider(this.bloc, {super.key, required super.child});
  StoriesProvider({Key? key, required Widget child}): bloc = StoriesBloc(), super(key: key, child: child);


  @override
  bool updateShouldNotify(oldWidget) {
    return true;
  }

  static StoriesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: StoriesProvider) as StoriesProvider).bloc;

  }
}