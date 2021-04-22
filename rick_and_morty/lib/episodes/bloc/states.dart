abstract class EpisodesState {
  bool busy;

  EpisodesState({this.busy = false});

  copy(bool busy) {
    return null;
  }
}

class InitState extends EpisodesState {
  InitState({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return InitState(busy: busy);
  }
}

class SuccessfulDownloadState extends EpisodesState {
  SuccessfulDownloadState({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return SuccessfulDownloadState(busy: busy);
  }
}

class UnsuccessfulDownloadState extends EpisodesState {
  UnsuccessfulDownloadState({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return UnsuccessfulDownloadState(busy: busy);
  }
}