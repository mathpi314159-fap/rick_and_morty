import 'package:rick_and_morty/models/episode.dart';
import 'package:rick_and_morty/models/packageHeader.dart';
import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/repository/Requests.dart';
import 'package:rick_and_morty/repository/characterRequest.dart';
import 'dart:convert' as convert;

import 'package:rick_and_morty/repository/episodeRequest.dart';

class EpisodeData {
  Episode? episode;
  List<Person> persons = [];

  late PackageHeader info;
}

class EpisodeRepo {
  final EpisodeData data = EpisodeData();
  String errorMessage = "";

  Future<bool> loadEpisode(int id) async {

    var episodeReq = EpisodeRequest();
    if ((data.episode = await episodeReq.requestId(id)) == null) {
      errorMessage = episodeReq.errorMessage;
      return false;
    }

    var charReq = CharacterRequest();
    for (var url in (data.episode!.characters ?? [])) {
      var person = await charReq.requestUrl(url);
      if (person != null) {
        data.persons.add(person);
      }
    }
    return true;
  }
}
