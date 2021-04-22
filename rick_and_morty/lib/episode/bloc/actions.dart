abstract class EpisodeAction {}

class InitBlocAction extends EpisodeAction {}

class LoadAction extends EpisodeAction {
  final int id;
  LoadAction(this.id);
}