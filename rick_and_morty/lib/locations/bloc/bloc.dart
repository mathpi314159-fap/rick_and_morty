import 'package:rick_and_morty/common/BlocStream.dart';

import 'states.dart';
import 'actions.dart';
import 'dataModel.dart';

class LocationsBloc {
  final LocationsRepo repo = LocationsRepo();

  LocationsState _state = InitState();

  LocationsState get state => _state;

  set state(state) {
    this._state = state;
    blocStream.eventOut = state;
  }

  BlocStream<LocationsState> blocStream = BlocStream();

  Future<void> mapEventToState(LocationsAction event) async {
    state = state.copy(true);

    if (event is GetInitialLocationsListAction) {
      state =
      (await repo.loadLocations(null))
          ? SuccessfulDownloadState()
          : UnsuccessfulDownloadState();
      return;
    }

    if (event is GetLocationsListAction) {
      if (repo.data.info.next != null) {
        repo.isLoading = true;
        state = (await repo.loadLocations(repo.data.info.next!))
            ? SuccessfulDownloadState()
            : UnsuccessfulDownloadState();
      }
      else {
        state = SuccessfulDownloadState();
      }
      repo.isLoading = false;
      return;
    }
  }

  void dispose() {}
}
