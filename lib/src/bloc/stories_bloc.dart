import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>(onListen: () {});
  final _repository = Respository();
  //getter to get stream/ rxdart = observable -depreciated
  get topIds => _topIds.stream;

  dispose() {
    _topIds.close();
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }
}
