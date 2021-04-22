import 'package:rick_and_morty/common/BlocStream.dart';

import 'states.dart';
import 'actions.dart';
import 'dataModel.dart';

class PersonBloc {
  final PersonRepo repo = PersonRepo();

  PersonState _state = InitState();

  PersonState get state => _state;

  set state(state) {
    this._state = state;
    blocStream.eventOut = state;
  }

  BlocStream<PersonState> blocStream = BlocStream();

  Future<void> mapEventToState(PersonAction event) async {
    state = state.copy(true);

    if (event is GetInitialPersonListAction) {
      state =
          (await repo.loadPersons(null))
              ? SuccessfulDownloadState()
              : UnsuccessfulDownloadState();
      return;
    }

    if (event is GetPersonListAction) {
      if (repo.data.info.next != null) {
        repo.isLoading = true;
        state = (await repo.loadPersons(repo.data.info.next!))
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
