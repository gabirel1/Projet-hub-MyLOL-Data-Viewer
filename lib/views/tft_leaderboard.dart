import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_op_gg/api_endpoints/profile.dart';
import 'package:my_op_gg/api_endpoints/tft_leaderboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

var isLoading = true;

class TftLeaderBoard extends StatefulWidget {
  const TftLeaderBoard({Key? key, required this.server}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Tft Leaderboard";
  final String server;

  @override
  _TftLeaderBoardState createState() => _TftLeaderBoardState();
}

class _TftLeaderBoardState extends State<TftLeaderBoard> {
  List<dynamic> _tftLeaderBoard = [];
  List<Widget> _tftLeaderBoardWidgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    APITFTLeaderboard apiTFTLeaderboard = APITFTLeaderboard();

    await apiTFTLeaderboard.fetch(server: widget.server);

    setState(
      () {
        _tftLeaderBoard = apiTFTLeaderboard.getTFTLeaderboard();
        isLoading = false;
      },
    );
    // for (int j = 0; j < _tftLeaderBoard.length; j++) {
    //   print(_tftLeaderBoard[j]);
    // }
    for (int i = 0; i < _tftLeaderBoard.length; i++) {
      _tftLeaderBoardWidgets.add(
        Container(
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
              ),
              (i == 0)
                  ? const Text(
                      "1",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : (i == 1)
                      ? const Text(
                          "2",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : (i == 2)
                          ? const Text(
                              "3",
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              "${i + 1}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
              ),
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "http://ddragon.leagueoflegends.com/cdn/11.23.1/img/profileicon/${_tftLeaderBoard[i]['icon']}.png",
                    imageBuilder: (
                      context,
                      imageProvider,
                    ) =>
                        Container(
                      width: 60.0,
                      height: 90.0,
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
                      top: 60,
                      left: 20,
                      // right: 20,
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
                        _tftLeaderBoard[i]['summonerLevel'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
              ),
              Text(
                _tftLeaderBoard[i]['summonerName'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                _tftLeaderBoard[i]['leaguePoints'].toString() + " LP",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  right: 10,
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
        child: (isLoading)
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const Text(
                    "TFT Leaderboard",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _tftLeaderBoardWidgets.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _tftLeaderBoardWidgets[index];
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
