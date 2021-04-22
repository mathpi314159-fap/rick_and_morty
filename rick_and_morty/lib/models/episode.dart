class Episode {
  int? id;
  String? name;
  String? airDate;
  String? episode;
  List<String>? characters;
  String? url;
  String? created;

  Episode(this.id, this.name, this.airDate, this.episode, this.characters,
      this.url, this.created);

  factory Episode.fromJson(Map<String, dynamic> json) {
    List<String> characters = [];
    var responseCharacters = json['characters'];
    for (var character in responseCharacters) {
      characters.add(character);
    }

    return new Episode(json['id'], json['name'], json['air_date'], json['episode'],
        characters, json['url'], json['created']);
  }

  factory Episode.onlyUrl(String? url) {
    return new Episode(null, null, null, null, null, url, null);
  }

  factory Episode.def() {
    return new Episode(null, null, null, null, null, null, null);
  }
}
