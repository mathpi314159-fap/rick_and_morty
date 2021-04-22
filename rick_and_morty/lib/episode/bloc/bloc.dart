import 'package:rick_and_morty/common/BlocStream.dart';

import 'states.dart';
import 'actions.dart';
import 'dataModel.dart';

class EpisodeBloc {
  final EpisodeRepo repo = EpisodeRepo();

  EpisodeState _state = InitState();

  EpisodeState get state => _state;

  set state(state) {
    this._state = state;
    blocStream.eventOut = state;
  }

  BlocStream<EpisodeState> blocStream = BlocStream();

  Future<void> mapEventToState(EpisodeAction event) async {
    state = state.copy(true);

    if (event is LoadAction) {
      state = (await repo.loadEpisode(event.id)) ? SuccessfulDownload() : FailedDownload(repo.errorMessage);
    }
  }

  void dispose() {}
}