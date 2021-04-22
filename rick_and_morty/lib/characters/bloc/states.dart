abstract class PersonState {
  bool busy;

  PersonState({this.busy = false});

  copy(bool busy) {
    return null;
  }
}

class InitState extends PersonState {
  InitState({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return InitState(busy: busy);
  }
}

class SuccessfulDownloadState extends PersonState {
  SuccessfulDownloadState({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return SuccessfulDownloadState(busy: busy);
  }
}

class UnsuccessfulDownloadState extends PersonState {
  UnsuccessfulDownloadState({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return UnsuccessfulDownloadState(busy: busy);
  }
}