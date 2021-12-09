import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_op_gg/utils/api_utils.dart';

class APIFlexLeaderboard {
  List<dynamic> _flexLeaderboard = [];

  APIFlexLeaderboard();

  fetch({server = 'euw1'}) async {
    try {
      // get the top 10 players in ranked solo
      var response = await getAPI(
        'league-exp/v4/entries/RANKED_FLEX_SR/CHALLENGER/I?page=1&',
        server: server,
      );

      // parse the response
      var parsedResponse = json.decode(response.body);
      for (var i = 0; i < parsedResponse.length && i < 10; i++) {
        var obj = {
          "summonerName": parsedResponse[i]['summonerName'],
          "leaguePoints": parsedResponse[i]['leaguePoints'],
          "wins": parsedResponse[i]['wins'],
          "losses": parsedResponse[i]['losses'],
          "icon": "",
          "summonerLevel": "",
        };
        var response2 = await getAPI(
            'summoner/v4/summoners/by-name/${parsedResponse[i]['summonerName']}',
            server: server);
        var parsedResponse2 = json.decode(response2.body);
        obj["icon"] = parsedResponse2['profileIconId'];
        obj["summonerLevel"] = parsedResponse2['summonerLevel'];
        _flexLeaderboard.add(obj);
      }
    } catch (e) {
      print("error == $e");
    }
  }

  List<dynamic> getFLEXLeaderboard() {
    return _flexLeaderboard;
  }
}
