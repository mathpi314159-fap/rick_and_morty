abstract class LocationsState {
  bool busy;

  LocationsState({this.busy = false});

  copy(bool busy) {
    return null;
  }
}

class InitState extends LocationsState {
  InitState({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return InitState(busy: busy);
  }
}

class SuccessfulDownloadState extends LocationsState {
  SuccessfulDownloadState({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return SuccessfulDownloadState(busy: busy);
  }
}

class UnsuccessfulDownloadState extends LocationsState {
  UnsuccessfulDownloadState({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return UnsuccessfulDownloadState(busy: busy);
  }
}