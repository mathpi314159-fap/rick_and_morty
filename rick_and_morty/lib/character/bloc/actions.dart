abstract class CharacterAction {}

class InitBlocAction extends CharacterAction {}

class LoadCharacter extends CharacterAction {
  final int id;
  LoadCharacter(this.id);
}