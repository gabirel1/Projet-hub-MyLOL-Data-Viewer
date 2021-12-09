import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_op_gg/utils/api_utils.dart';

class APITFTLeaderboard {
  List<dynamic> _tftLeaderboard = [];

  APITFTLeaderboard();

  fetch({server = 'euw1'}) async {
    try {
      // get the top 10 players in ranked solo
      var response = await getAPITFT(
        'league/v1/challenger',
        server: server,
      );

      // parse the response
      var parsedResponse = json.decode(response.body);
      List<dynamic> parsedResponseDatas = parsedResponse['entries'];
      parsedResponseDatas
          .sort((a, b) => b['leaguePoints'].compareTo(a['leaguePoints']));
      for (var i = 0; i < parsedResponseDatas.length && i < 10; i++) {
        var obj = {
          "summonerName": parsedResponseDatas[i]['summonerName'],
          "leaguePoints": parsedResponseDatas[i]['leaguePoints'],
          "wins": parsedResponseDatas[i]['wins'],
          "losses": parsedResponseDatas[i]['losses'],
          "icon": "",
          "summonerLevel": "",
        };
        var response2 = await getAPITFT(
            'summoner/v1/summoners/by-name/${parsedResponseDatas[i]['summonerName']}',
            server: server);
        var parsedResponse2 = json.decode(response2.body);
        obj["icon"] = parsedResponse2['profileIconId'];
        obj["summonerLevel"] = parsedResponse2['summonerLevel'];
        _tftLeaderboard.add(obj);
      }
    } catch (e) {
      print("error == $e");
    }
  }

  List<dynamic> getTFTLeaderboard() {
    return _tftLeaderboard;
  }
}
