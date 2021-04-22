abstract class LocationAction {}

class InitBlocAction extends LocationAction {}

class LoadAction extends LocationAction {
  final int id;
  LoadAction(this.id);
}