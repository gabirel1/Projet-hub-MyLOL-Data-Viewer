import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_op_gg/api_endpoints/profile.dart';
import 'package:my_op_gg/api_endpoints/solo_leaderboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

var isLoading = true;

class SoloLeaderBoard extends StatefulWidget {
  const SoloLeaderBoard({Key? key, required this.server}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Solo Leaderboard";
  final String server;

  @override
  _SoloLeaderBoardState createState() => _SoloLeaderBoardState();
}

class _SoloLeaderBoardState extends State<SoloLeaderBoard> {
  List<dynamic> _soloLeaderBoard = [];
  List<Widget> _soloLeaderBoardWidgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

/*   Widget boardWidget(var object) {
    return Container(
      child: Column(
        children: [

        ],
      ),
    );
  } */

  void loadData() async {
    APISoloLeaderboard apiSoloLeaderboard = APISoloLeaderboard();

    await apiSoloLeaderboard.fetch(server: widget.server);

    setState(
      () {
        _soloLeaderBoard = apiSoloLeaderboard.getSoloLeaderboard();
        isLoading = false;
      },
    );
    for (int j = 0; j < _soloLeaderBoard.length; j++) {
      print(_soloLeaderBoard[j]);
    }
    for (int i = 0; i < _soloLeaderBoard.length; i++) {
      _soloLeaderBoardWidgets.add(
        Container(
          child: Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "http://ddragon.leagueoflegends.com/cdn/11.23.1/img/profileicon/${_soloLeaderBoard[i]['icon']}.png",
                    imageBuilder: (
                      context,
                      imageProvider,
                    ) =>
                        Container(
                      width: 80.0,
                      height: 110.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
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
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 80,
                      left: 30,
                      right: 40,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(
                            5,
                            5,
                          ),
                        ),
                      ),
                      child: Text(
                        _soloLeaderBoard[i]['summonerLevel'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Text(
                  _soloLeaderBoard[i]['summonerName'],
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
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
        child: Center(
          child: (isLoading)
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    const Text(
                      "Solo Leaderboard",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    // Expanded(
                    //   child: ListView(
                    //     children: _soloLeaderBoardWidgets,
                    //   ),
                    // ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _soloLeaderBoardWidgets.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _soloLeaderBoardWidgets[index];
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
