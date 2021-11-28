import 'dart:convert';
import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:my_op_gg/utils/api_utils.dart';

class APIProfile {
  var isError = false;
  var profileIconId = 0;
  var summonerLevel = 0;
  var soloInformations;
  var flexInformations;
  // var

  APIProfile();

  fetch(String username, {server = 'euw1'}) async {
    String summonerId = '';
    String summonerAccountId = '';
    String summonerPuuid = '';

    try {
      var response = await getAPI('summoner/v4/summoners/by-name/$username',
          server: server);
      if (response.statusCode == 200) {
        var body = await jsonDecode(response.body);
        summonerId = body['id'];
        summonerLevel = body['summonerLevel'];
        summonerAccountId = body['accountId'];
        summonerPuuid = body['puuid'];
        profileIconId = body['profileIconId'];
      } else {
        var status = response.statusCode;
        print("there was an error $status");
        isError = true;
        return;
      }
      var response2 = await getAPI('league/v4/entries/by-summoner/$summonerId',
          server: server);
      if (response2.statusCode == 200) {
        var body = jsonDecode(response2.body);
        if (body != null && body[0]["queueType"] == "RANKED_SOLO_5x5") {
          soloInformations = body[0];
        } else if (body != null && body[0]["queueType"] == "RANKED_FLEX_SR") {
          flexInformations = body[0];
        }
        if (body != null &&
            body[0] != null &&
            body[1]["queueType"] == "RANKED_SOLO_5x5") {
          soloInformations = body[1];
        } else if (body != null &&
            body[0] != null &&
            body[1]["queueType"] == "RANKED_FLEX_SR") {
          flexInformations = body[1];
        }
      } else {
        var status = response2.statusCode;
        print("there was an error $status");
        isError = true;
        return;
      }
    } catch (e) {
      isError = true;
      return;
    }
  }

  String getProfileIconId() {
    print(profileIconId);
    return profileIconId.toString();
  }

  String getSummonerLevel() {
    return summonerLevel.toString();
  }

  String getSoloRanking() {
    print("soloInformations == $soloInformations");
    if (soloInformations == null) return "Unranked";
    return soloInformations['tier'] + ' ' + soloInformations['rank'];
  }

  String getFlexRanking() {
    print("flexInformations == $flexInformations");
    if (flexInformations == null) return "Unranked";
    return flexInformations['tier'] + ' ' + flexInformations['rank'];
  }

  String getSoloLP() {
    if (soloInformations == null) return "0 LP";
    return soloInformations['leaguePoints'].toString() + ' LP';
  }

  String getFlexLP() {
    if (flexInformations == null) return "0 LP";
    return flexInformations['leaguePoints'].toString() + ' LP';
  }

  String getSoloWinLoose() {
    if (soloInformations == null) return "0W 0L (0%)";
    double percentage = (soloInformations['wins'] /
        (soloInformations['wins'] + soloInformations['losses']) *
        100);
    var winPercentage = percentage.ceil().toInt().toString();
    print("winPercentage == $winPercentage");
    return soloInformations['wins'].toString() +
        'W ' +
        soloInformations['losses'].toString() +
        'L ($winPercentage%)';
  }

  String getFlexWinLoose() {
    if (flexInformations == null) return "0W 0L (0%)";
    double percentage = (flexInformations['wins'] /
        (flexInformations['wins'] + flexInformations['losses']) *
        100);
    var winPercentage = percentage.ceil().toInt().toString();
    print("winPercentage == $winPercentage");
    return flexInformations['wins'].toString() +
        'W ' +
        flexInformations['losses'].toString() +
        'L ($winPercentage%)';
  }

  String getSoloRankingPicture() {
    if (soloInformations == null) return 'assets/Emblem_Unranked.png';
    switch (soloInformations['tier']) {
      case 'IRON':
        return 'assets/Emblem_Iron.png.png';
      case 'BRONZE':
        return 'assets/Emblem_Bronze.png';
      case 'SILVER':
        return 'assets/Emblem_Silver.png';
      case 'GOLD':
        return 'assets/Emblem_Gold.png';
      case 'PLATINUM':
        return 'assets/Emblem_Platinum.png';
      case 'DIAMOND':
        return 'assets/Emblem_Diamond.png';
      case 'MASTER':
        return 'assets/Emblem_Master.png';
      case 'GRANDMASTER':
        return 'assets/Emblem_Grandmaster.png';
      case 'CHALLENGER':
        return 'assets/Emblem_Challenger.png';
      default:
        return 'assets/Emblem_Unranked.png';
    }
  }

  String getFlexRankingPicture() {
    if (flexInformations == null) return 'assets/Emblem_Unranked.png';
    switch (flexInformations['tier']) {
      case 'IRON':
        return 'assets/Emblem_Iron.png.png';
      case 'BRONZE':
        return 'assets/Emblem_Bronze.png';
      case 'SILVER':
        return 'assets/Emblem_Silver.png';
      case 'GOLD':
        return 'assets/Emblem_Gold.png';
      case 'PLATINUM':
        return 'assets/Emblem_Platinum.png';
      case 'DIAMOND':
        return 'assets/Emblem_Diamond.png';
      case 'MASTER':
        return 'assets/Emblem_Master.png';
      case 'GRANDMASTER':
        return 'assets/Emblem_Grandmaster.png';
      case 'CHALLENGER':
        return 'assets/Emblem_Challenger.png';
      default:
        return 'assets/Emblem_Unranked.png';
    }
  }
}
