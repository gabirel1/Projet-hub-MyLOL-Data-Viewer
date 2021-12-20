import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_op_gg/utils/api_utils.dart';

class APIDetailedGamesInfo {
  var isError = false;
  List<dynamic> playersInformations = [];
  var gameInformation = {};

  APIDetailedGamesInfo();

  fetch(String matchId, {server = 'euw1'}) async {
    try {
      var response =
          await getAPIMatchs("match/v5/matches/$matchId", server: server);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        gameInformation = {
          "gameDuration": body["info"]["gameDuration"],
          "gameMode": body["info"]["gameMode"],
          "gameCreation": body["info"]["gameCreation"],
        };
        for (int j = 0; j < body['info']['participants'].length; j++) {
          playersInformations.add({
            "items": [],
            "championId": body['info']['participants'][j]['championId'],
            "championName": body['info']['participants'][j]['championName'],
            "summonerName": body['info']['participants'][j]['summonerName'],
            "summonerId": body['info']['participants'][j]['summonerId'],
            "summonerLevel": body['info']['participants'][j]['summonerLevel'],
            "summoner1Id": body['info']['participants'][j]['summoner1Id'],
            "summoner2Id": body['info']['participants'][j]['summoner2Id'],
            "item0": body['info']['participants'][j]['item0'],
            "item1": body['info']['participants'][j]['item1'],
            "item2": body['info']['participants'][j]['item2'],
            "item3": body['info']['participants'][j]['item3'],
            "item4": body['info']['participants'][j]['item4'],
            "item5": body['info']['participants'][j]['item5'],
            "item6": body['info']['participants'][j]['item6'],
            "kills": body['info']['participants'][j]['kills'],
            "deaths": body['info']['participants'][j]['deaths'],
            "assists": body['info']['participants'][j]['assists'],
            "win": body['info']['participants'][j]['win'],
          });
          playersInformations[j]["items"].add(playersInformations[j]['item0']);
          playersInformations[j]["items"].add(playersInformations[j]['item1']);
          playersInformations[j]["items"].add(playersInformations[j]['item2']);
          playersInformations[j]["items"].add(playersInformations[j]['item3']);
          playersInformations[j]["items"].add(playersInformations[j]['item4']);
          playersInformations[j]["items"].add(playersInformations[j]['item5']);
          playersInformations[j]["items"].add(playersInformations[j]['item6']);
        }
      }
    } catch (e) {
      print('error == $e');
      isError = true;
      return;
    }
  }

  getGameInformation() {
    return gameInformation;
  }

  List<dynamic> getPlayersInformations() {
    return playersInformations;
  }
}
