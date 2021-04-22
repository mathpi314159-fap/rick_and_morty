import 'package:rick_and_morty/common/BlocStream.dart';

import 'states.dart';
import 'actions.dart';
import 'dataModel.dart';

class EpisodesBloc {
  final EpisodesRepo repo = EpisodesRepo();

  EpisodesState _state = InitState();

  EpisodesState get state => _state;

  set state(state) {
    this._state = state;
    blocStream.eventOut = state;
  }

  BlocStream<EpisodesState> blocStream = BlocStream();

  Future<void> mapEventToState(EpisodesAction event) async {
    state = state.copy(true);

    if (event is GetInitialEpisodeListAction) {
      state =
          (await repo.loadEpisodes(null))
              ? SuccessfulDownloadState()
              : UnsuccessfulDownloadState();
      return;
    }

    if (event is GetEpisodeListAction) {
      if (repo.data.info.next != null) {
        repo.isLoading = true;
        state = (await repo.loadEpisodes(repo.data.info.next!))
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
