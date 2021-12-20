import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_op_gg/api_endpoints/detailed_games_infos.dart';
import 'package:my_op_gg/api_endpoints/profile.dart';
import 'package:my_op_gg/api_endpoints/solo_leaderboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

var isLoading = true;

class DetailedGameInfo extends StatefulWidget {
  const DetailedGameInfo(
      {Key? key, required this.matchId, this.server = "euw1"})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Game Informations";
  final String matchId;
  final String server;

  @override
  _DetailedGameInfoState createState() => _DetailedGameInfoState();
}

class _DetailedGameInfoState extends State<DetailedGameInfo> {
  var _gameInformation;
  List<dynamic> _playerInformations = [];
  List<Widget> _playerInformationsWidgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    APIDetailedGamesInfo api = APIDetailedGamesInfo();
    await api.fetch(widget.matchId, server: widget.server);

    setState(() {
      _gameInformation = api.getGameInformation();
      _playerInformations = api.getPlayersInformations();
      print(_playerInformations);
    });
    buildPlayerInformations();
    isLoading = false;
  }

  void buildPlayerInformations() {
    for (int i = 0; i < _playerInformations.length; i++) {
      if (_playerInformations[i]['win'] == true) {
        _playerInformationsWidgets.add(
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              // color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _playerInformations[i]['summonerName'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://ddragon.leagueoflegends.com/cdn/11.24.1/img/champion/${_playerInformations[i]['championName']}.png",
                    imageBuilder: (context, imageProvider) => Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.072,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (
                      context,
                      url,
                    ) =>
                        const CircularProgressIndicator(),
                    errorWidget: (
                      context,
                      url,
                      error,
                    ) =>
                        const Icon(
                      Icons.error,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                  ),
                ),
                // show game informations
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _playerInformations[i]['championName'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        _playerInformations[i]['kills'].toString() +
                            " / " +
                            _playerInformations[i]['deaths'].toString() +
                            " / " +
                            _playerInformations[i]['assists'].toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                      // show all the items
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          children: [
                            ..._playerInformations[i]['items'].map(
                              (item) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                  height: MediaQuery.of(context).size.height *
                                      0.034,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "https://ddragon.leagueoflegends.com/cdn/11.24.1/img/item/${item}.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 0.3,
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    _playerInformationsWidgets.add(Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    ));
    for (int i = 0; i < _playerInformations.length; i++) {
      if (_playerInformations[i]['win'] == false) {
        _playerInformationsWidgets.add(
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              // color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _playerInformations[i]['summonerName'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://ddragon.leagueoflegends.com/cdn/11.24.1/img/champion/${_playerInformations[i]['championName']}.png",
                    imageBuilder: (context, imageProvider) => Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.072,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (
                      context,
                      url,
                    ) =>
                        const CircularProgressIndicator(),
                    errorWidget: (
                      context,
                      url,
                      error,
                    ) =>
                        const Icon(
                      Icons.error,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                  ),
                ),
                // show game informations
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _playerInformations[i]['championName'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        _playerInformations[i]['kills'].toString() +
                            " / " +
                            _playerInformations[i]['deaths'].toString() +
                            " / " +
                            _playerInformations[i]['assists'].toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                      // show all the items
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          children: [
                            ..._playerInformations[i]['items'].map(
                              (item) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                  height: MediaQuery.of(context).size.height *
                                      0.034,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "https://ddragon.leagueoflegends.com/cdn/11.24.1/img/item/${item}.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 0.3,
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  Widget playersInfos() {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.025,
      ),
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.67,
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.grey,
      //     width: 2,
      //   ),
      //   borderRadius: BorderRadius.circular(5),
      // ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ..._playerInformationsWidgets,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: (isLoading)
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Text(
                          "${_gameInformation['gameMode']}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                  _gameInformation['gameCreation'])
                              .toString()
                              .substring(0, 10),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          (_gameInformation['gameDuration'] / 60)
                                  .floor()
                                  .toString() +
                              ":" +
                              ((_gameInformation['gameDuration'] / 60 -
                                          (_gameInformation['gameDuration'] /
                                                  60)
                                              .floor()) *
                                      60)
                                  .floor()
                                  .toString()
                                  .padLeft(2, '0'),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  playersInfos(),
                ],
              ),
      ),
    );
  }
}
