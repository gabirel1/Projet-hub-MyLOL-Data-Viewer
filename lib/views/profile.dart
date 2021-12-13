import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_op_gg/api_endpoints/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

var isLoading = true;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.username, this.server = "euw1"})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Profile";
  final String username;
  final String server;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String iconURL = "";
  String username = "";
  String summonerLevel = "";
  String soloIconURL = "assets/Emblem_Unranked.png";
  String soloRanking = "";
  String soloLPs = "";
  String soloWinLooses = "";
  String flexIconURL = "assets/Emblem_Unranked.png";
  String flexRanking = "";
  String flexLPs = "";
  String flexWinLooses = "";
  List<dynamic> championsInformations = [];
  List<Widget> championsMasteriesWidgets = [];
  List<dynamic> lastGames = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    print(widget.username);
    print(widget.server);
    APIProfile apiProfile = APIProfile();
    await apiProfile.fetch(widget.username, server: widget.server);
    setState(
      () {
        iconURL =
            'http://ddragon.leagueoflegends.com/cdn/11.24.1/img/profileicon/' +
                apiProfile.getProfileIconId() +
                '.png';
        username = widget.username;
        summonerLevel = apiProfile.getSummonerLevel();
        soloRanking = apiProfile.getSoloRanking();
        flexRanking = apiProfile.getFlexRanking();
        soloLPs = apiProfile.getSoloLP();
        flexLPs = apiProfile.getFlexLP();
        soloWinLooses = apiProfile.getSoloWinLoose();
        flexWinLooses = apiProfile.getFlexWinLoose();
        soloIconURL = apiProfile.getSoloRankingPicture();
        flexIconURL = apiProfile.getFlexRankingPicture();
        championsInformations = apiProfile.getChampionsInformations();
        lastGames = apiProfile.getGamesInformations();
        buildChampionMasteriesWidget();
        isLoading = false;
      },
    );
    print("iconURL == $iconURL");
  }

  void buildChampionMasteriesWidget() {
    for (int i = 0; i < championsInformations.length; i++) {
      championsMasteriesWidgets.add(
        Container(
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://ddragon.leagueoflegends.com/cdn/11.24.1/img/champion/${championsInformations[i]['name']}.png",
                imageBuilder: (context, imageProvider) => Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.064,
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                    left: 20,
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
                      championsInformations[i]['level'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget championsMasteries() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.47,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...championsMasteriesWidgets,
            ],
          ),
        ));
  }

  Widget queuesInformations() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            padding: const EdgeInsets.only(
              left: 5,
              top: 5,
              bottom: 5,
            ),
            height: MediaQuery.of(context).size.height * 0.13,
            width: MediaQuery.of(context).size.width * 0.68,
            child: Column(
              children: [
                Stack(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          soloIconURL,
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                        ),
                        const Text(
                          "Solo Ranked Match",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 55,
                            left: 60,
                          ),
                        ),
                        Text(
                          soloRanking,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 90,
                            left: 60,
                          ),
                        ),
                        Text(
                          soloLPs,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 125,
                            left: 60,
                          ),
                        ),
                        Text(
                          soloWinLooses,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 15,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            padding: const EdgeInsets.only(
              left: 5,
              top: 5,
              bottom: 5,
            ),
            height: MediaQuery.of(context).size.height * 0.13,
            width: MediaQuery.of(context).size.width * 0.68,
            child: Column(
              children: [
                Stack(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          flexIconURL,
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                        ),
                        const Text(
                          "Flex 5:5 Rank",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 55,
                            left: 60,
                          ),
                        ),
                        Text(
                          flexRanking,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 90,
                            left: 60,
                          ),
                        ),
                        Text(
                          flexLPs,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 125,
                            left: 60,
                          ),
                        ),
                        Text(
                          flexWinLooses,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
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
        child: (isLoading ||
                iconURL ==
                    "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/profileicon/0.png")
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: iconURL,
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
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 80,
                                  left: 27,
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
                                    summonerLevel,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          username,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                        ),
                        championsMasteries(),
                      ],
                    ),
                  ),
                  queuesInformations(),
                ],
              ),
      ),
    );
  }
}
