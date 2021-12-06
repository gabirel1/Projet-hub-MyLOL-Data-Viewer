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
      var response = await getAPI(
        'league/v4/entries/RANKED_TFT',
        server: server,
      );

      // parse the response
      var parsedResponse = json.decode(response.body);
      for (var i = 0; i < parsedResponse.length && i < 10; i++) {
        _tftLeaderboard.add(parsedResponse[i]);
      }
    } catch (e) {
      print("error == $e");
    }
  }

  List<dynamic> getTFTLeaderboard() {
    return _tftLeaderboard;
  }
}
