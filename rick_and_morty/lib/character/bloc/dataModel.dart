import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/models/episode.dart';
import 'package:rick_and_morty/repository/Requests.dart';
import 'dart:convert' as convert;

import 'package:rick_and_morty/repository/characterRequest.dart';
import 'package:rick_and_morty/repository/episodeRequest.dart';

class CharacterData {
  Person? person;
}

class CharacterRepo {
  final CharacterData data = CharacterData();

  String errorMessage = "";

  Future<bool> loadPerson(int id) async {
    var charReq = CharacterRequest();
    data.person = await charReq.requestId(id);
    if (data.person == null) {
      errorMessage = charReq.errorMessage;
      return false;
    }

    List<Episode>? episodes = [];
    for (var episode in data.person!.episodes ?? []) {
      var epReq = EpisodeRequest();
      var newEpisode = await epReq.requestUrl(episode.url);
      episodes.add(newEpisode ?? Episode.def());
    }
    data.person!.episodes = episodes;
    
    return true;
  }
}
