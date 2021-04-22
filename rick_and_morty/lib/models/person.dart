import 'episode.dart';
import 'location.dart';

class Person {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  String? image;
  Location? origin;
  Location? location;
  List<Episode>? episodes;
  String? created;
  String? url;

  Person(
      this.id,
      this.name,
      this.status,
      this.species,
      this.type,
      this.gender,
      this.image,
      this.origin,
      this.location,
      this.created,
      this.episodes,
      this.url) {
    if (type == "") type = "-";
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    List<Episode> episodes = [];
    var response = json['episode'];
    for (var ep in response) {
      episodes.add(Episode.onlyUrl(ep));
    }

    return new Person(
        json['id'],
        json['name'],
        json['status'],
        json['species'],
        json['type'],
        json['gender'],
        json['image'],
        Location.fromJsonForCharacter(json['origin']),
        Location.fromJsonForCharacter(json['location']),
        json['created'],
        episodes,
        json['url']);
  }

  factory Person.def() {
    return new Person(
        null, null, null, null, null, null, null, null, null, null, null, null);
  }
}
