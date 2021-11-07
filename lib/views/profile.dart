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
            'http://ddragon.leagueoflegends.com/cdn/10.13.1/img/profileicon/' +
                apiProfile.getProfileIconId() +
                '.png';
        username = widget.username;
        summonerLevel = apiProfile.getSummonerLevel();
        isLoading = false;
      },
    );
    print("iconURL == $iconURL");
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
                    "http://ddragon.leagueoflegends.com/cdn/10.13.1/img/profileicon/0.png")
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
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
