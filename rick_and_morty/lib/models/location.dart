class Location {
  int? id;
  String? name;
  String? type;
  String? dimension;
  List<String>? residents;
  String? url;
  String? created;

  Location(this.id, this.name, this.type, this.dimension, this.residents,
      this.url, this.created);

  Location.forCharacter(this.name, this.url);

  factory Location.fromJsonForCharacter(Map<String, dynamic> json) {
    return new Location.forCharacter(json['name'], json['url']);
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    List<String> residents = [];
    var response = json['residents'];
    for (var resident in response) {
      residents.add(resident);
    }

    return new Location(json['id'], json['name'], json['type'],
        json['dimension'], residents, json['url'], json['created']);
  }
}
