import 'package:rick_and_morty/common/BlocStream.dart';

import 'states.dart';
import 'actions.dart';
import 'dataModel.dart';

class LocationBloc {
  final LocationRepo repo = LocationRepo();

  LocationState _state = InitState();

  LocationState get state => _state;

  set state(state) {
    this._state = state;
    blocStream.eventOut = state;
  }

  BlocStream<LocationState> blocStream = BlocStream();

  Future<void> mapEventToState(LocationAction event) async {
    state = state.copy(true);

    if (event is LoadAction) {
      state = (await repo.loadLocation(event.id)) ? SuccessfulDownload() : FailedDownload(repo.errorMessage);
    }
  }

  void dispose() {}
}