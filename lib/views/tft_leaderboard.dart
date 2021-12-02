import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_op_gg/api_endpoints/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

var isLoading = true;

class TftLeaderBoard extends StatefulWidget {
  const TftLeaderBoard({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Tft Leaderboard";

  @override
  _TftLeaderBoardState createState() => _TftLeaderBoardState();
}

class _TftLeaderBoardState extends State<TftLeaderBoard> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    setState(
      () {
        isLoading = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 2.0),
        child: Text(
          "Tft Leaderboard",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
