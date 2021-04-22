abstract class CharacterState {
  bool busy;

  CharacterState({this.busy = false});

  copy(bool busy) {
    return null;
  }
}

class InitState extends CharacterState {
  InitState({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return InitState(busy: busy);
  }
}

class SuccessfulDownload extends CharacterState {
  SuccessfulDownload({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return SuccessfulDownload(busy: busy);
  }
}

class FailedDownload extends CharacterState {
  final String _message;
  FailedDownload(this._message, {bool busy = false}) : super(busy: busy);

  String get message => _message;

  @override
  copy(bool busy) {
    return FailedDownload(message, busy: busy);
  }
}