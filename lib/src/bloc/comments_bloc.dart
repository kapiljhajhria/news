import 'dart:async';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //Stream
  Stream<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  //Sink
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    //init commentsFetcher and pipe it to output
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  StreamTransformer<int, Map<int, Future<ItemModel>>> _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (Map<int, Future<ItemModel>> cache, int id, index) {
      cache[id] = _repository.fetchItem(id);
      cache[id].then((ItemModel item) {
        item.kids.forEach((kidId) {
          fetchItemWithComments(kidId);
        });
      });
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
