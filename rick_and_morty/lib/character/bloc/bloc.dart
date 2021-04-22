import 'package:rick_and_morty/common/BlocStream.dart';

import 'states.dart';
import 'actions.dart';
import 'dataModel.dart';

class CharacterBloc {
  final CharacterRepo repo = CharacterRepo();

  CharacterState _state = InitState();

  CharacterState get state => _state;

  set state(state) {
    this._state = state;
    blocStream.eventOut = state;
  }

  BlocStream<CharacterState> blocStream = BlocStream();

  Future<void> mapEventToState(CharacterAction event) async {
    state = state.copy(true);

    if (event is LoadCharacter) {
      state = (await repo.loadPerson(event.id)) ? SuccessfulDownload() : FailedDownload(repo.errorMessage);
    }
  }

  void dispose() {}
}
