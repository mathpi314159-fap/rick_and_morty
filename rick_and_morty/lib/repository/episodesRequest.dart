import 'package:rick_and_morty/models/episode.dart';
import 'package:rick_and_morty/repository/baseRequest.dart';
import 'package:rick_and_morty/models/packageHeader.dart';
import 'dart:convert' as convert;
import 'Requests.dart';

class EpisodesRequest extends BaseRequest {
  late PackageHeader packageHeader;

  Future<List<Episode>?> request(
      [String url = "https://rickandmortyapi.com/api/episode"]) async {
    List<Episode> episodes = [];

    try {
      var response = await Requests.httpGet(url);
      var jsonResponse = convert.jsonDecode(response.body);

      var info = jsonResponse["info"];
      packageHeader = PackageHeader.fromJson(info);

      var resultsList = jsonResponse["results"];
      for (var result in resultsList) {
        episodes.add(Episode.fromJson(result));
      }
    } catch (e) {
      errorMessage = e.toString();
      return null;
    }
    return episodes;
  }
}
