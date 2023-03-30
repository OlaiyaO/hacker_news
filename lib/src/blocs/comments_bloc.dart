import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  // Streams
  Stream<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;


  // Sink
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream.transform(_commentsTransformer()).pipe(
        _commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>((accumulated,
        int id, index) {
      print(index);
      accumulated[id] = _repository.fetchItem(id);
      accumulated[id]!.then((ItemModel item){
        item.kids?.forEach((kidId) => fetchItemWithComments(kidId));
      });
      return accumulated;
    }, <int, Future<ItemModel>> {});
  }


  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }

}