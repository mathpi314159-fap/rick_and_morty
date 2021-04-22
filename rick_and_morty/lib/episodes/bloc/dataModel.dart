import 'package:rick_and_morty/models/episode.dart';
import 'package:rick_and_morty/models/packageHeader.dart';
import 'package:rick_and_morty/repository/Requests.dart';
import 'dart:convert' as convert;

import 'package:rick_and_morty/repository/episodesRequest.dart';

class EpisodesData {

  List<Episode> episodes = [];

  late PackageHeader info;

}

class EpisodesRepo {
  final EpisodesData data = EpisodesData();
  var isLoading = false;
  var errorMessage = "";

  Future<bool> loadEpisodes(String? url) async {
    var epReq = EpisodesRequest();
    var episodes =
    (url == null) ? await epReq.request() : await epReq.request(url);
    if (episodes == null) {
      errorMessage = epReq.errorMessage;
      return false;
    }
    data.info = epReq.packageHeader;
    for (var loc in episodes) {
      data.episodes.add(loc);
    }
    return true;
  }

}
