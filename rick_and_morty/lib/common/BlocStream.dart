import 'dart:async';

class BlocStream<T> {

  final StreamController<T> _streamController = StreamController.broadcast();

  Stream<T> get stream => _streamController.stream;

  set eventOut(T data) {
    _streamController.add(data);
  }
}