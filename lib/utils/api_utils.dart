import 'package:http/http.dart' as http;
import 'package:my_op_gg/utils/secrets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// this function is used to make an api call to the league of legends api
Future<http.Response> getAPI(endPoint, {server = 'euw1'}) async {
  final token = apiKey;
  final headers = {
    'X-Riot-Token': token,
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  final url = 'https://$server.api.riotgames.com/lol/$endPoint';
  return http.get(Uri.parse(url), headers: headers);
}

Future<http.Response> getAPITFT(endpoint, {server = 'euw1'}) async {
  final token = apiKey;
  final headers = {
    'X-Riot-Token': token,
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  final url = 'https://$server.api.riotgames.com/tft/$endpoint';
  return http.get(Uri.parse(url), headers: headers);
}

Future<http.Response> getAPIMatchs(endpoint, {server = 'euw1'}) async {
  final token = apiKey;
  final headers = {
    'X-Riot-Token': token,
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  var myServer = "europe";
  if (server == "na1") {
    myServer = "americas";
  }
  if (server == "eun1" || server == "euw1") {
    myServer = "europe";
  }
  if (server == "kr") {
    myServer = "asia";
  }
  final url = 'https://$myServer.api.riotgames.com/lol/$endpoint';
  return http.get(Uri.parse(url), headers: headers);
}
