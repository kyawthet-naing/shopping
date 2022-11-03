import 'dart:async';

class SearchBloc {
  StreamController<bool> searchController = StreamController.broadcast();

  Stream<bool> get stream => searchController.stream;

  disposed() => searchController.close();
}
