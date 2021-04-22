abstract class LocationState {
  bool busy;

  LocationState({this.busy = false});

  copy(bool busy) {
    return null;
  }
}

class InitState extends LocationState {
  InitState({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return InitState(busy: busy);
  }
}

class SuccessfulDownload extends LocationState {
  SuccessfulDownload({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return SuccessfulDownload(busy: busy);
  }
}

class FailedDownload extends LocationState {
  final String _message;
  FailedDownload(this._message, {bool busy = false}) : super(busy: busy);

  String get message => _message;

  @override
  copy(bool busy) {
    return FailedDownload(message, busy: busy);
  }
}