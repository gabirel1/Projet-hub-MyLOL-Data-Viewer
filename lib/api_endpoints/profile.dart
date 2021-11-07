import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:my_op_gg/utils/api_utils.dart';

class APIProfile {
  var isError = false;
  var profileIconId = 0;
  var summonerLevel = 0;
  // var

  APIProfile();

  fetch(String username, {server = 'euw1'}) async {
    String summonerId = '';
    String summonerAccountId = '';
    String summonerPuuid = '';

    try {
      var response =
          await getAPI('summoners/by-name/$username', server: server);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        summonerId = body['id'];
        summonerLevel = body['summonerLevel'];
        summonerAccountId = body['accountId'];
        summonerPuuid = body['puuid'];
        profileIconId = body['profileIconId'];
      } else {
        isError = true;
        return;
      }
    } catch (e) {
      isError = true;
      return;
    }
  }
}
